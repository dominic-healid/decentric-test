//
//  TasksViewController.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        return tableView
    }()
    
    let taskPresenter = TasksViewPresenter()
    var selectedTask: Task?
    var array = [Task]()
    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         *   Finish this simple task recording app
         *   1. Make sure all defects are fixed
         *   2. Show a view (can be UIAlertController or any) that can add/edit the task.
         *   3. Show the added task in a UITableView/CollectionView
         *   4. Allow the user to toggle it as completed
         *   5. Allow the user to delete a task
         *
         **/
        array.append(Task())
        configureView()
        handleTaskPresenterResult()
    }
    
    func handleTaskPresenterResult() {
        taskPresenter.changeResult = { type in
            switch type {
            case .reloadTable:
                self.tableView.reloadData()
            }
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        self.navigationItem.title = "Tasks"
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUpdateTapped))
        self.navigationItem.rightBarButtonItem = add
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = 50
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "taskCell")
    }
    
    @objc
    func addUpdateTapped(_ isUpdate: Bool = false) {
        let title = isUpdate ? "Update Task" : "Add New Task"
        let buttonTitle = isUpdate ? "Update" : "Save"
        
        let alertController = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Task"
            textField.text = isUpdate ? self.selectedTask?.description : ""
        }
        let saveAction = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: { alert -> Void in
            let name = alertController.textFields![0] as UITextField
            
            if isUpdate {
                if let task = self.selectedTask {
                    task.description = name.text ?? ""
                    self.updateTaskInList(task: task)
                }
            } else {
                let task = Task()
                task.description = name.text ?? ""
                self.addTaskToList(task: task)
            }
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}

extension TasksViewController: TaskView {
    
    func displayTasks(tasks: [Task]) {
        
    }
    
    func addTaskToList(task: Task) {
        self.taskPresenter.savedTask(task: task)
    }
    
    func removeTaskFromList(task: Task) {
        self.taskPresenter.deletedTask(taskId: task.id)
    }
    
    func updateTaskInList(task: Task) {
        self.taskPresenter.updatedTask(task: task)
    }
    
}

extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskPresenter.taskProvider.allTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        let task = taskPresenter.taskProvider.allTasks[indexPath.row]
        
        cell.textLabel?.text = task.description
        cell.accessoryType = task.isCompleted ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let task = taskPresenter.taskProvider.allTasks[indexPath.row]
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            self.selectedTask = task
            self.addUpdateTapped(true)
        }
        editAction.backgroundColor = .blue

        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            self.removeTaskFromList(task: task)
        }
        deleteAction.backgroundColor = .red
        
        let checkAction = UITableViewRowAction(style: .normal, title: task.isCompleted ? "Uncheck" : "Check") { (rowAction, indexPath) in
            task.isCompleted = !task.isCompleted
            self.updateTaskInList(task: task)
        }
        checkAction.backgroundColor = .orange

        return [checkAction, editAction,deleteAction]
    }
    
}
