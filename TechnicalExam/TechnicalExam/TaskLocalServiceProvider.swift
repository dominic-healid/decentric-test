//
//  TaskLocalServiceProvider.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import Foundation

class TaskLocalServiceProvider : TaskLocalService {
    
    let defaults = UserDefaults.standard
    let taskKey = "Tasks"
    var allTasks = [Task]()
    init() {
        if let objects = defaults.value(forKey: taskKey) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Task] {
                allTasks = objectsDecoded
            }
        }
    }
    
    func save(task: Task) {
        if let last = allTasks.last {
            task.id = last.id + 1
        } else {
            task.id = 1
        }
        
        allTasks.append(task)
        execute()
    }
    
    func update(task: Task) {
        guard let index = allTasks.lastIndex(where: { $0.id == task.id }) else {
            return
        }
        
        allTasks.remove(at: index)
        allTasks.insert(task, at: index)
        execute()
    }
    
    func delete(id: Int) {
        allTasks.removeAll(where: { $0.id == id})
        execute()
    }
    
    func execute() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allTasks){
            UserDefaults.standard.set(encoded, forKey: taskKey)
        }
    }
    
    func findAll() -> [Task] {
        if let objects = defaults.value(forKey: taskKey) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Task] {
                allTasks = objectsDecoded
            }
        }
        return allTasks
        
    }
    
}
