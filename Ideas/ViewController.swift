//
//  ViewController.swift
//  Ideas
//
//  Created by Austin Wood on 02/04/2017.
//  Copyright © 2017 Austin Wood. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let category: [String] = ["groceries", "amazon", "today", "week"]
    let imageName: [String?] = ["milk", "amazon", nil, nil]
    let bigLabelText: [String?] = [nil, nil, "今日", "今週"]
    
    
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

