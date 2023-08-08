//
//  Task.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/08/03.
//

import Foundation
import RealmSwift

public class Task: Object, Identifiable {
    @Persisted (primaryKey:true)  public var id = UUID().uuidString
    @Persisted public var name: String?
    @Persisted public var desc: String?
    @Persisted public var created: Date = Date()
    @Persisted public var completeDate: Date?
    @Persisted public var dueDate: Date?
    @Persisted public var scheduleTime: Bool = false
}
