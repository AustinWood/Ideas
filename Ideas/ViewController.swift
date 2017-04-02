//
//  ViewController.swift
//  Ideas
//
//  Created by Austin Wood on 02/04/2017.
//  Copyright © 2017 Austin Wood. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let category: [String] = ["groceries", "amazon", "today", "week"]
    let imageName: [String?] = ["milk", "amazon", nil, nil]
    let bigLabelText: [String?] = [nil, nil, "今日", "今週"]
    
    //////////////////////////////////////////////
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupCollectionView()
    }
    
    //////////////////////////////////////////////
    // MARK: - Collection View
    
    func setupCollectionView() {
        collectionView.layoutIfNeeded()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionViewWidth = collectionView.frame.width
        let collectionViewHeight = collectionView.frame.height
        print("width: \(collectionViewWidth), height: \(collectionViewHeight)")
        
        let cellWidth: CGFloat = 150
        let cellHeight = cellWidth
        let cellSpacing = (collectionViewWidth - (cellWidth * 2)) / 3
        let lineSpacing: CGFloat = 60
        let topInset = (collectionViewHeight - (cellHeight * 2) - lineSpacing) / 2
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: topInset, left: cellSpacing, bottom: 0, right: cellSpacing)
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        
        collectionView.collectionViewLayout = layout
        collectionView.layoutIfNeeded()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected \(indexPath.row)")
    }

}

