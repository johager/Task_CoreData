//
//  CoreDataStack.swift
//  Task-CoreData
//
//  Created by James Hager on 3/29/22.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {

          let container = NSPersistentContainer(name: "DataModel")
          container.loadPersistentStores { (_, error) in
              if let error = error {
                  fatalError("Error loading persistent stores: \(error)")
              }
          }
          return container
      }()

      static var context: NSManagedObjectContext { container.viewContext }

      static func saveContext() {
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
                  print("Error saving context: \(error)")
              }
          }
      }
}
