//
//  TestTableViewController.swift
//  SimpleToDoList
//
//  Created by Minseop Kim on 2020/10/15.
//  Copyright © 2020 Minseop Kim. All rights reserved.
//

import UIKit
import CoreData

class TestTableViewController: UITableViewController {

    @IBOutlet var testTableView: UITableView!
        
    
    let formatter: DateFormatter = {
       let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewWillAppear(true)
        CompletedDataManager.shared.fatchToDoList()
        testTableView.reloadData()

    }
    override func viewWillAppear(_ animated: Bool) {
        testTableView.reloadData()
    }
    
    @IBAction func reloadData(_ sender: Any) {
        testTableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CompletedDataManager.shared.completedDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        let target = CompletedDataManager.shared.completedDoList[indexPath.row]
        cell.textLabel?.text = target.toDoTitle
        cell.detailTextLabel?.text = formatter.string(from: target.dates ?? Date() )
        return cell
        
    }


}
