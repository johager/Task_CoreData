//
//  Project.swift
//  Task-CoreData
//
//  Created by James Hager on 3/30/22.
//

import CoreData

@objc(Project)
class Project: NSManagedObject {
    
    // MARK: - CoreData Properties
    
    @NSManaged var name: String
    
    @NSManaged var tasks: NSSet
    
    // MARK: - Properties
    
    var uncompletedTaskCount: Int { (tasks.allObjects as! [Task]).filter( { !$0.isComplete }).count }
    
    // MARK: - Init
    
    @discardableResult convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
    }
}
