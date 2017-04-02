//
//  IndexVC.swift
//  Ideas
//
//  Created by Austin Wood on 02/04/2017.
//  Copyright © 2017 Austin Wood. All rights reserved.
//

import UIKit
import CoreData

class IndexVC: UIViewController {
    
    let moc: NSManagedObjectContext? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var category: String = ""
    
    //////////////////////////////////////////////
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
//        setupCollectionView()
        print(category)
        loadData()
    }
    
    //////////////////////////////////////////////
    // MARK: - Core Data
    
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
        }
        catch {
            fatalError("Error retrieving grocery item")
        }
    }
}
