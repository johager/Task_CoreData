//
//  TaskController.swift
//  Task-CoreData
//
//  Created by James Hager on 3/29/22.
//

import CoreData

class TaskController {
    
    static let shared = TaskController()
    
    var tasks = [Task]()
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        return request
    }()
    
    private init() {
        fetch()
    }
    
    // MARK: - CRUD
    
    func create(name: String, notes: String?, dueDate: Date?) {
        tasks.append(Task(name: name, notes: notes, dueDate: dueDate))
        CoreDataStack.saveContext()
    }
    
    func fetch() {
        do {
            tasks = try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }
    
    func update(_ task: Task, name: String, notes: String?, dueDate: Date?) {
        task.update(name: name, notes: notes, dueDate: dueDate)
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(atIndex index: Int) {
        tasks[index].isComplete.toggle()
        CoreDataStack.saveContext()
    }
}
