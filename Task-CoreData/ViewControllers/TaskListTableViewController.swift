//
//  TaskListTableViewController.swift
//  Task-CoreData
//
//  Created by James Hager on 3/29/22.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

extension TaskListTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: TaskController.shared.tasks[indexPath.row], andDelegate: self)
        
        return cell
    }
}

// MARK: -UITableViewDelegate

extension TaskListTableViewController {

}

// MARK: - TaskTableViewCellDelegate

extension TaskListTableViewController: TaskTableViewCellDelegate {
    
    func completionButtonTapped(for cell: TaskTableViewCell) {
        print(#function)
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        TaskController.shared.toggleIsComplete(atIndex: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
