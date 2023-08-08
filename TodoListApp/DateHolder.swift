//
//  DateHolder.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/07/21.
//

import SwiftUI
import RealmSwift

class DateHolder: ObservableObject{
    @Published var date = Date()
    @Published var taskItems: [Task] = []


    let calendar: Calendar = Calendar.current

    func moveDate(_ days:Int) {
        date = calendar.date(byAdding: .day, value: days, to: date)!
        refreshTaskItems()
    }

    init(date: Date = Date(), taskItems: [Task] = []) {
        self.date = date
        self.taskItems = dailyTaskFetch()

    }
    
    func refreshTaskItems() {
        taskItems = fetchTaskItems()
    }

    func fetchTaskItems() -> [Task]{
        return dailyTaskFetch()
    }

    func dailyTaskFetch() -> [Task]{
        let start = calendar.startOfDay(for:date)
        let end = calendar.date(byAdding: .day,value:1,to: start)
        let request = Array(TaskService.shared.allTask().filter("dueDate >= %@ AND dueDate < %@", start as NSDate,end! as NSDate))
        return request
    }
//
//    private func sortOrder() ->[NSSortDescriptor]{
//        let completedDateSort = NSSortDescriptor(keyPath: \TaskItem.completeDate, ascending: true)
//        let timeSort = NSSortDescriptor(keyPath: \TaskItem.scheduleTime, ascending: true)
//        let dueDateSort = NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)
//        return [completedDateSort, timeSort, dueDateSort]
//    }
//
//    private func predicate() -> NSPredicate{
//        let start = calendar.startOfDay(for: date)
//        let end = calendar.date(byAdding: .day,value:1,to: start)
//        return NSPredicate(format: "dueDate >= %@ AND dueDate < %@", start as NSDate,end! as NSDate)
//    }

}
