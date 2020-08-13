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
    
}

@available(iOS 13.0, *)
extension ToDoListTableViewController: UITableViewDelegate {
    
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let unreadAction = UIContextualAction(style: .normal, title: "Unread") { (action, view, completion) in
                completion(true)
            }
            
            unreadAction.backgroundColor = UIColor.systemBlue
            unreadAction.image = UIImage(named: "mail")
            let configuration = UISwipeActionsConfiguration(actions: [unreadAction])
            return configuration
        }
    
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let delectAction = UIContextualAction(style: .normal, title: "삭제") { (action, view, completion) in
                let alert = UIAlertController(title: "삭제", message: "할일을 삭제하시겠습니까?", preferredStyle: .alert)
                let delectButten = UIAlertAction(title: "삭제", style: .default) { (target) in
                    let target = DataManager.shared.toDoList[indexPath.row]
                    DataManager.shared.delectToDo(target)
                    DataManager.shared.toDoList.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                let cancleButten = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                alert.addAction(delectButten)
                alert.addAction(cancleButten)
                self.present(alert, animated: true, completion: nil)
                
                completion(true)
            }
            delectAction.backgroundColor = UIColor.systemRed
            
            let completeAction = UIContextualAction(style: .destructive, title: "완료") { (action, view, completion) in
                print("완료버튼 선택")
                completion(true)
            }
            completeAction.backgroundColor = UIColor.systemBlue
            
            let editAction = UIContextualAction(style: .normal, title: "편집") { (action, view, complection) in
                complection(true)
            }
            
            
    //        row action과 마찬가지로 배열에 추가된 순서대로 셀 오른쪽에서부터 생성된다.
            let configuration = UISwipeActionsConfiguration(actions: [completeAction,delectAction, editAction])
            
    //        이 속성을 True로 했을때 셀전체를 스와이프 했을때 첫번째 액션이 수행된다.
            configuration.performsFirstActionWithFullSwipe = true
            return configuration
            
        }
    
}
