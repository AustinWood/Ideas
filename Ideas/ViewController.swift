//
//  ViewController.swift
//  Ideas
//
//  Created by Austin Wood on 02/04/2017.
//  Copyright © 2017 Austin Wood. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let moc: NSManagedObjectContext? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var collectionView: UICollectionView!
    
    let category: [String] = ["amazon", "groceries", "week", "today"]
    let imageName: [String?] = ["amazon", "milk", nil, nil]
    let bigLabelText: [String?] = [nil, nil, "今週", "今日"]
    
    //////////////////////////////////////////////
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        setupCollectionView()
        addGestureRecognizers()
        loadData()
        didLongPress = false
    }
    
    //////////////////////////////////////////////
    // MARK:- Gesture Recognizers
    
    func addGestureRecognizers() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.didSingleTap))
        singleTap.numberOfTapsRequired = 1
        self.collectionView!.addGestureRecognizer(singleTap)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.3
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    func didSingleTap(_ gesture: UITapGestureRecognizer) {
        if validateTap(gestureLocation: gesture.location(in: self.collectionView!)) {
            addIdea(category: selectedCategory)
        }
    }
    
    var didLongPress = false
    
    func handleLongPress(_ gesture: UITapGestureRecognizer) {
        if validateTap(gestureLocation: gesture.location(in: self.collectionView!)) && !didLongPress {
            didLongPress = true
            performSegue(withIdentifier: "goToIndex", sender: self)
        }
    }
    
    var selectedCategory = ""
    
    func validateTap(gestureLocation: CGPoint) -> Bool {
        if let selectedIndexPath = self.collectionView!.indexPathForItem(at: gestureLocation) {
            selectedCategory = category[selectedIndexPath.row]
            return true
        }
        return false
    }
    
    //////////////////////////////////////////////
    // MARK: - Collection View
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionViewWidth: CGFloat = 375 // collectionView.frame.width
        let collectionViewHeight: CGFloat = 603 // collectionView.frame.height
        
        let cellWidth: CGFloat = 150
        let cellHeight = cellWidth
        let cellSpacing = (collectionViewWidth - (cellWidth * 2)) / 2
        let lineSpacing: CGFloat = 85
        let topInset = (collectionViewHeight - (cellHeight * 2) - lineSpacing) / 2 + 40
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: topInset, left: cellSpacing, bottom: 0, right: cellSpacing)
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        
        collectionView.collectionViewLayout = layout
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
        if imageName[indexPath.row] != nil {
            cell.image.isHidden = false
            cell.image.image = UIImage(named: imageName[indexPath.row]!)
            cell.bigLabel.text = ""
        } else {
            cell.image.isHidden = true
            cell.bigLabel.text = bigLabelText[indexPath.row]
        }
        
        return cell
    }
    
    //////////////////////////////////////////////
    // MARK: - Core Data
    
    func addIdea(category: String) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField: UITextField) in
            textField.autocapitalizationType = .sentences
            textField.autocorrectionType = .yes
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] (action: UIAlertAction) in
            let ideaTitle: String?
            if alertController.textFields?.first?.text != "" {
                ideaTitle = alertController.textFields?.first?.text
            } else { return }
            let newIdea = Idea(context: (self?.moc)!)
            newIdea.title = ideaTitle
            newIdea.category = category
            do { try self?.moc?.save() }
            catch { fatalError("Error storing data") }
            self?.loadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    func loadData() {
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "Idea")
        do {
            let results = try moc?.fetch(request)
            print("Number of results: \(results?.count ?? 42000)")
        }
        catch {
            fatalError("Error retrieving grocery item")
        }
    }
    
    //////////////////////////////////////////////
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToIndex" {
            let destinationController = segue.destination as! IndexVC
            destinationController.category = selectedCategory
        }
    }
}

