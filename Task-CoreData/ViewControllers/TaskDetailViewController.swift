//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by James Hager on 3/29/22.
//

import UIKit

class TaskDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Properties
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - View methods
    
    func updateViews() {
        if task == nil {
            title = "Add Task"
        } else {
            title = "Task Details"
        }
        
        guard let task = task else { return }
        taskNameTextField?.text = task.name
        taskNotesTextView?.text = task.notes
        if let dueDate = task.dueDate {
            taskDueDatePicker?.date = dueDate
        }
    }
    
    // MARK: - Actions

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = taskNameTextField?.text,
              let notes = taskNotesTextView?.text,
              !name.isEmpty,
              !notes.isEmpty
        else { return }
        
        if let task = task {
            TaskController.shared.update(task, name: name, notes: notes, dueDate: taskDueDatePicker?.date)
        } else {
            TaskController.shared.create(name: name, notes: notes, dueDate: taskDueDatePicker?.date)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
