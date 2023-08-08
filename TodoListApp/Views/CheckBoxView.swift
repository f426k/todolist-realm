//
//  CheckBoxView.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/07/21.
//

import SwiftUI

struct CheckBoxView: View {
//    @Environment(\.managedObjectContext) private var viewContext
    var dateHolder: DateHolder
//    @ObservedObject var passedTaskItem: Task

    var completeDate: Date?
    var id: String
    init(completeDate: Date? = nil, id: String,dateHolder:DateHolder) {
        self.completeDate = completeDate
        self.id = id
        self.dateHolder = dateHolder
    }

    var body: some View {
        Image(systemName: completeDate != nil ? "checkmark.circle.fill" : "circle")
            .foregroundColor(completeDate != nil ? .green : .secondary)
            .onTapGesture {
                try! isCompleteTask()
            }
    }

    func isCompleteTask() throws {
        try TaskService.shared.toggleCompleteTasks(id: id)
        dateHolder.refreshTaskItems()
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(completeDate: nil, id: UUID().uuidString, dateHolder: DateHolder())
    }
}
