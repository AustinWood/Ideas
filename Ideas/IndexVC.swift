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
