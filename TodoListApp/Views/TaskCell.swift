//
//  TaskCell.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/07/21.
//

import SwiftUI

struct TaskCell: View {
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem

    var body: some View {
        CheckBoxView(passedTaskItem:passedTaskItem).environmentObject(dateHolder)

        Text(passedTaskItem.name ?? "")
            .padding(.horizontal)

        if passedTaskItem.isCompleted() && passedTaskItem.scheduleTime{
            Spacer()
            Text(passedTaskItem.dueDate)
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(passedTaskItem:TaskItem())
    }
}
