//
//  Task.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/08/03.
//

import Foundation
import RealmSwift

public class Task: Object {
    @Persisted public var name = ""
    @Persisted public var desc = ""
    @Persisted public var created: Date
    @Persisted public var completeDate: Date?
    @Persisted public var dueDate: Date
    @Persisted public var scheduleTime: Bool = false
}
