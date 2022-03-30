//
//  Date+.swift
//  Task-CoreData
//
//  Created by James Hager on 3/30/22.
//

import Foundation

extension Date {
    
    var asDueDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: self)
    }
}
