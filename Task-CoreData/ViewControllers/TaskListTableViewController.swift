//
//  TaskListTableViewController.swift
//  Task-CoreData
//
//  Created by James Hager on 3/29/22.
//

import UIKit

class TaskListTableViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - View Methods
    
    func setUpViews() {
        segmentedControl.setTitle("To Do", forSegmentAt: 0)
        segmentedControl.setTitle("Completed", forSegmentAt: 1)
        segmentedControl.addTarget(self, action: #selector(handleSegmentedControlChanged(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        
        tableView.dataSource = self
    }
    
    // MARK: - Actions
    
    @objc func handleSegmentedControlChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            TaskController.shared.showUncompleted()
        case 1:
            TaskController.shared.showCompleted()
        default:
            break
        }
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showTaskDetails",
              let indexPath = tableView.indexPathForSelectedRow,
              let destination = segue.destination as? TaskDetailViewController
        else { return }
        
        destination.task = TaskController.shared.tasks[indexPath.row]
    }
}

// MARK: - UITableViewDataSource

extension TaskListTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: TaskController.shared.tasks[indexPath.row], andDelegate: self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        TaskController.shared.delete(atIndex: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - UITableViewDelegate

extension TaskListTableViewController: UITableViewDelegate {

}

// MARK: - TaskTableViewCellDelegate

extension TaskListTableViewController: TaskTableViewCellDelegate {
    
    func completionButtonTapped(for cell: TaskTableViewCell) {
        print(#function)
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        TaskController.shared.toggleIsComplete(atIndex: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
