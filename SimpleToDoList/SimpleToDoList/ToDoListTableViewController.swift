//
//  ToDoListTableViewController.swift
//  SimpleToDoList
//
//  Created by Minseop Kim on 2020/07/28.
//  Copyright © 2020 Minseop Kim. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
class ToDoListTableViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    let formatter: DateFormatter = {
       let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    
    
    
    var list = [("할일을 추가하세요", "날짜")]
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewWillAppear(true)
        DataManager.shared.fatchToDoList()
        listTableView.reloadData()


    }
    
    @IBAction func addTodoList(_ sender: Any) {
        let alert = UIAlertController(title: "새로운 할일", message: "새로운 할일을 추가해 봐요", preferredStyle: .alert)
        alert.addTextField { (title) in
            title.placeholder = "할일"
        }
        let addButten = UIAlertAction(title: "추가", style: .default) { (addToDo) in
            guard let textField = alert.textFields else {return}
            guard let addToDo = textField.first?.text else {return}
            DataManager.shared.addNewToDo(addToDo)
            self.listTableView.reloadData()

        }
        let cancleButten = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(addButten)
        alert.addAction(cancleButten)
        present(alert, animated: true,completion: nil)
        
    }
    

}

@available(iOS 13.0, *)
extension ToDoListTableViewController: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let target = DataManager.shared.toDoList[indexPath.row]
        cell.textLabel?.text = target.toDoTitle
        cell.detailTextLabel?.text = formatter.string(from: target.dates ?? Date())
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let target = DataManager.shared.toDoList[indexPath.row]
            DataManager.shared.delectToDo(target)
            DataManager.shared.toDoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}

@available(iOS 13.0, *)
extension ToDoListTableViewController: UITableViewDelegate {
    
}
