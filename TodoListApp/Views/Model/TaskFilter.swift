//
//  TaskFilter.swift
//  TodoListApp
//
//  Created by 高嶋芙佳 on 2023/07/21.
//

import SwiftUI

enum TaskFilter: String{
    static var allFilters: [TaskFilter]{
        return [.NonCompleted, .Completed,.OverDue, .All]
    }
    case All = "All"
    case NonCompleted = "To Do"
    case Completed = "Completed"
    case OverDue = "Over Due"
}
