//
//  ToDoListTableViewController.swift
//  SimpleToDoList
//
//  Created by Minseop Kim on 2020/07/28.
//  Copyright © 2020 Minseop Kim. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    
    
    var list = [("할일을 추가하세요", "날짜")]
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func addTodoList(_ sender: Any) {
        let alert = UIAlertController(title: "새로운 할일", message: "새로운 할일을 추가해 봐요", preferredStyle: .alert)
        alert.addTextField { (title) in
            title.placeholder = "할일"
        }
        let addButten = UIAlertAction(title: "추가", style: .default) { (addToDo) in
            guard let textField = alert.textFields else {return}
            guard let addToDo = textField.first?.text else {return}
            
            let now = Date()
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KO")
            formatter.setLocalizedDateFormatFromTemplate("yyyyMMMMdE")
            let addTime = formatter.string(from: now)
            self.list.append((addToDo, addTime))
            let insertPath = IndexPath(row: self.list.count - 1, section: 0)
            self.listTableView.beginUpdates()
            self.listTableView.insertRows(at: [insertPath], with: .automatic)
            self.listTableView.endUpdates()
        }
        let cancleButten = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(addButten)
        alert.addAction(cancleButten)
        present(alert, animated: true,completion: nil)
        
    }
    

}

extension ToDoListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row].0
        cell.detailTextLabel?.text = list[indexPath.row].1
        return cell
    }
    
    
}

extension ToDoListTableViewController: UITableViewDelegate {
    
}
