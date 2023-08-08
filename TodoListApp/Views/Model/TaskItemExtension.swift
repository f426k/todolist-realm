//
//  TaskItemExtension.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/07/21.
//

import SwiftUI

extension Task{
    func isCompleted() -> Bool{
        return completeDate != nil
    }

    func isOverdue() -> Bool{
        if let due = dueDate{
            return !isCompleted() && scheduleTime && due < Date()
        }
        return false
    }

    func overDueColor() -> Color{
        return isOverdue() ? .red : .black
    }

    func dueDateTimeOnly() -> String{
        if let due = dueDate{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: due)
        }
        return ""
    }
}
