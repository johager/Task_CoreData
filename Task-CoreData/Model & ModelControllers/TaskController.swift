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
    private var allTasks = [Task]()
    
    private init() {
        showUncompleted()
    }
    
    // MARK: - Assign Tasks
    
    func setProject(_ project: Project) {
        self.project = project
        allTasks = Array(project.tasks as! Set<Task>)
        showUncompleted()
        print("\(#function) - name: \(project.name), allTasks.count: \(allTasks.count), tasks.count: \(tasks.count)")
    }
    
    // MARK: - CRUD
    
    func create(name: String, notes: String?, dueDate: Date?) {
        tasks.append(Task(project: project, name: name, notes: notes, dueDate: dueDate))
        CoreDataStack.saveContext()
    }
    
    func showUncompleted() {
        tasks = allTasks.filter { !$0.isComplete}
    }
    
    func showCompleted() {
        tasks = allTasks.filter { $0.isComplete}
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
