//
//  TaskService.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/08/03.
//

import Foundation
import RealmSwift

public class TaskService {
    static let shared = TaskService(configuration: .defaultConfiguration)
    private let configuration: Realm.Configuration

    let calendar: Calendar = Calendar.current

    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }

    func allTask() -> Results<Task> {
        let realm = try! Realm(configuration: configuration)
        return realm.objects(Task.self)
    }
    
    func createTask(name: String, desc: String, scheduleTime: Bool, dueDate: Date, id: String) throws {
        let realm = try! Realm(configuration: configuration)
        let taskItem: Task
        if id == "" {
            taskItem = Task()
            taskItem.id = UUID().uuidString
        } else {
            taskItem = realm.object(ofType: Task.self, forPrimaryKey: id)!
        }

        try realm.write {
            taskItem.name = name
            taskItem.desc = desc
            taskItem.created = Date()
            taskItem.scheduleTime = scheduleTime
            taskItem.dueDate = dueDate
            realm.add(taskItem)
        }
    }

    func deleteTask(id: String) throws {
        let realm = try! Realm(configuration: configuration)
        guard let taskItem = realm.object(ofType: Task.self, forPrimaryKey: id) else {
            return
        }
        try realm.write {
            realm.delete(taskItem)
        }
    }

    func toggleCompleteTasks(id: String) throws {
        let realm = try! Realm(configuration: configuration)
        guard let taskItem = realm.object(ofType: Task.self, forPrimaryKey: id) else {
            return
        }
        try realm.write {
            if !taskItem.isCompleted() {
                taskItem.completeDate = Date()
            } else {
                taskItem.completeDate = nil
            }
            realm.add(taskItem, update: .modified)
        }
    }
}
