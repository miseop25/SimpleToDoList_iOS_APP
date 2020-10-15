//
//  CompletedDataManager.swift
//  SimpleToDoList
//
//  Created by Minseop Kim on 2020/10/15.
//  Copyright © 2020 Minseop Kim. All rights reserved.
//

import Foundation
import CoreData

class CompletedDataManager {
    static let shared = CompletedDataManager()
    private init() {
        
    }
    
    var completedDoList = [CompletedList]()
    
    var mainContenxt: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    func fatchToDoList()  {
        let request: NSFetchRequest<CompletedList> = CompletedList.fetchRequest()
        
        let sortByDate = NSSortDescriptor(key: "dates", ascending: false)
        request.sortDescriptors = [sortByDate]
        
        do {
            completedDoList = try mainContenxt.fetch(request)
        }catch {
            print("error")
        }
    }
    
    func addNewToDo(_ title: String?) {
        let newToDo = CompletedList(context: mainContenxt)
        newToDo.toDoTitle = title
        newToDo.dates = Date()
        
        completedDoList.insert(newToDo, at: 0)
        saveContext()
    }
    
    func delectToDo(_ todo: ToDoList?) {
        if let todo = todo {
            mainContenxt.delete(todo)
            saveContext()
        }
    }
    
    //  MARK : CoreData
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "CompletedData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    

}
