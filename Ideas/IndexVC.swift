//
//  IndexVC.swift
//  Ideas
//
//  Created by Austin Wood on 02/04/2017.
//  Copyright © 2017 Austin Wood. All rights reserved.
//

import UIKit
import CoreData

class IndexVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let moc: NSManagedObjectContext? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var category: String = ""
    
    //////////////////////////////////////////////
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addIdea))
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setupTableView()
        loadData()
    }
    
    //////////////////////////////////////////////
    // MARK: - Table View
    
    @IBOutlet weak var tableView: UITableView!
    
    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
        tableView.separatorColor = UIColor.clear
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IndexItemCell
        cell.selectionStyle = .none
        cell.label.text = ideas[indexPath.row].title
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = CustomColor.dark1
        } else {
            cell.backgroundColor = CustomColor.dark2
        }
        return cell
    }
    
    //////////////////////////////////////////////
    // MARK: - Core Data
    
    var ideas: [Idea] = []
    
    func addIdea() {
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
            newIdea.category = self?.category
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
            var filteredResults: [Idea] = []
            for result in results! {
                let idea: Idea = result as! Idea
                if idea.category == category {
                    filteredResults.append(idea)
                    print(idea.title!)
                }
            }
            print("Number of results: \(results?.count ?? 42000)")
            ideas = filteredResults
            tableView.reloadData()
        }
        catch {
            fatalError("Error retrieving grocery item")
        }
    }
}
