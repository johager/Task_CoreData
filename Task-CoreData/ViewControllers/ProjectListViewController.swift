//
//  ProjectListViewController.swift
//  Task-CoreData
//
//  Created by James Hager on 3/30/22.
//

import UIKit

class ProjectListViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        ProjectController.shared.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - View Methods
    
    func setUpViews() {
        tableView.dataSource = self
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Project", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Project Name..."
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        let add = UIAlertAction(title: "Add", style: .default) { _ in
            guard let name = alert.textFields?[0].text,
                  !name.isEmpty
            else { return }
            ProjectController.shared.create(name: name)
        }
        
        alert.addAction(cancel)
        alert.addAction(add)
        
        present(alert, animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // showTaskList
        guard segue.identifier == "showTaskList",
              let indexPath = tableView.indexPathForSelectedRow,
              let destination = segue.destination as? TaskListTableViewController
        else { return }
        let project = ProjectController.shared.projects[indexPath.row]
        TaskController.shared.setProject(project)
        destination.title = "\(project.name) Tasks"
    }
}

// MARK: - UITableViewDataSource

extension ProjectListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProjectController.shared.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        
        let project = ProjectController.shared.projects[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = project.name
        config.secondaryText = "\(project.uncompletedTaskCount) uncompleted"
        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        ProjectController.shared.delete(atIndex: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - ProjectControllerDelegate

extension ProjectListViewController: ProjectControllerDelegate {
    
    func createdNewProject() {
        tableView.reloadData()
    }
}
