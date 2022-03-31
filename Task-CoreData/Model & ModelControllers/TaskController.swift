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
    
    private var project: Project!
    
    private init() { }
    
    // MARK: - Assign Tasks
    
    func setProject(_ project: Project) {
        self.project = project
        showUncompleted()
    }
    
    // MARK: - CRUD
    
    func create(name: String, notes: String?, dueDate: Date?) {
        tasks.append(Task(project: project, name: name, notes: notes, dueDate: dueDate))
        CoreDataStack.saveContext()
    }
    
    func showUncompleted() {
        guard let project = project else { return }
        tasks = Array(project.tasks as! Set<Task>).filter { !$0.isComplete}
    }
    
    func showCompleted() {
        guard let project = project else { return }
        tasks = Array(project.tasks as! Set<Task>).filter { $0.isComplete}
    }
    
    func update(_ task: Task, name: String, notes: String?, dueDate: Date?) {
        task.update(name: name, notes: notes, dueDate: dueDate)
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(atIndex index: Int) {
        tasks[index].isComplete.toggle()
        tasks.remove(at: index)
        CoreDataStack.saveContext()
    }
    
    func delete(atIndex index: Int) {
        CoreDataStack.context.delete(tasks[index])
        CoreDataStack.saveContext()
        tasks.remove(at: index)
    }
}
