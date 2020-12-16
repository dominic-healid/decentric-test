//
//  TaskPresenter.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import Foundation

enum TasksViewPresenterResult {
    case reloadTable
}

class TasksViewPresenter : TaskPresenter{
    let taskProvider = TaskLocalServiceProvider()
    var changeResult: ((TasksViewPresenterResult) -> ())? = nil
    
    
    func taskClicked() {
        
    }
    
    func savedTask(task: Task) {
        taskProvider.save(task: task)
        changeResult?(.reloadTable)
    }
    
    func updatedTask(task: Task) {
        taskProvider.update(task: task)
        changeResult?(.reloadTable)
    }
    
    func checkedTask(taskId: Int) {
        changeResult?(.reloadTable)
    }
    
    func uncheckedTask(taskId: Int) {
        changeResult?(.reloadTable)
    }
    
    func deletedTask(taskId: Int) {
        taskProvider.delete(id: taskId)
        changeResult?(.reloadTable)
    }
    
    
}
