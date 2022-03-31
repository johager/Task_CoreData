//
//  ProjectController.swift
//  Task-CoreData
//
//  Created by James Hager on 3/30/22.
//

import CoreData

protocol ProjectControllerDelegate: AnyObject {
    func createdNewProject()
}

// MARK: -

class ProjectController {
    
    static let shared = ProjectController()
    
    var projects = [Project]()
    
    var delegate: ProjectControllerDelegate?
    
    private lazy var fetchRequest: NSFetchRequest<Project> = {
        let request = NSFetchRequest<Project>(entityName: "Project")
        return request
    }()
    
    private init() {
        fetch()
    }
    
    // MARK: - CRUD
    
    func create(name: String) {
        projects.append(Project(name: name))
        CoreDataStack.saveContext()
        delegate?.createdNewProject()
    }
    
    func fetch() {
        do {
            projects = try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }

    func delete(atIndex index: Int) {
        let project = projects[index]
        for task in project.tasks.allObjects as! [Task] {
            CoreDataStack.context.delete(task)
        }
        CoreDataStack.context.delete(project)
        CoreDataStack.saveContext()
        projects.remove(at: index)
    }
}
