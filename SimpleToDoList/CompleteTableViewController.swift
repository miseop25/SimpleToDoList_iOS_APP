//
//  CompleteTableViewController.swift
//  SimpleToDoList
//
//  Created by Minseop Kim on 2020/08/28.
//  Copyright © 2020 Minseop Kim. All rights reserved.
//

import UIKit

class CompleteTableViewController: UIViewController {

    @IBOutlet weak var completeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewWillAppear(true)
        completeTableView.reloadData()

        // Do any additional setup after loading the view.
    }
    

}


extension CompleteTableViewController: UITableViewDelegate {
    
    
}

extension CompleteTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Test"
        cell.detailTextLabel?.text = "detail Test"
        return cell
    }
    
    
}
