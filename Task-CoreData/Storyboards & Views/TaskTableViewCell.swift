//
//  TaskTableViewCell.swift
//  Task-CoreData
//
//  Created by James Hager on 3/30/22.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func completionButtonTapped(for cell: TaskTableViewCell)
}

// MARK: -

class TaskTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: TaskTableViewCellDelegate?
    
    // MARK: - View Methods
    
    func configure(with task: Task, andDelegate delegate: TaskTableViewCellDelegate) {
        taskNameLabel?.text = task.name
        
        if let dueDate = task.dueDate {
            dueDateLabel?.text = "Due \(dueDate.asDueDateString)"
        }
        
        let image = task.isComplete ? UIImage(named: "complete") : UIImage(named: "incomplete")
        completionButton.setImage(image, for: .normal)
        
        self.delegate = delegate
    }
    
    // MARK: - Actions

    @IBAction func completionButtonTapped(_ sender: UIButton) {
        delegate?.completionButtonTapped(for: self)
    }
}
