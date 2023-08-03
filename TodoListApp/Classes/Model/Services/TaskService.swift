//
//  TaskService.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/08/03.
//

import Foundation
import RealmSwift

struct TaskService {
    private let configuration: Realm.Configuration

    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }

    func allTask() -> Results<Task> {
        let realm = try! Realm(configuration: configuration)
        return realm.objects(Task.self)
    }
    func createTask(name: String, desc: String, scheduleTime: Bool, dueDate: Date) throws {
        let realm = try! Realm(configuration: configuration)
        try realm.write {
            let task = Task()
            task.name = name
            task.desc = desc
            task.created = Date()
            task.scheduleTime = scheduleTime
            task.dueDate = dueDate
            realm.add(task)
        }
    }
}
