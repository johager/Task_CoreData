//
//  Task.swift
//  Task-CoreData
//
//  Created by James Hager on 3/29/22.
//

import CoreData

@objc(Task)
class Task: NSManagedObject {
    
    // MARK: - CoreData Properties
    
    @NSManaged var dueDate: Date?
    @NSManaged var isComplete: Bool
    @NSManaged var name: String
    @NSManaged var notes: String?
    
    @NSManaged var project: Project
    
    // MARK: - Init
    
    @discardableResult convenience init(project: Project, name: String, notes: String?, dueDate: Date?, isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.project = project
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
    
    func update(name: String, notes: String?, dueDate: Date?) {
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
    }
}
