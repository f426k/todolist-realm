//
//  TaskCell.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/07/21.
//

import SwiftUI

struct TaskCell: View {
    var dateHolder: DateHolder
//    @ObservedObject var passedTaskItem: Task

    var name: String?
    var completeDate: Date?
    var id: String
    var scheduleTime:Bool
    var dueDate: Date?

    init( name: String?, completeDate: Date? = nil, id: String, scheduleTime: Bool, dueDate: Date? = nil, dateHolder: DateHolder) {
        self.name = name
        self.completeDate = completeDate
        self.id = id
        self.scheduleTime = scheduleTime
        self.dueDate = dueDate
        self.dateHolder = dateHolder
    }

    var body: some View {
        HStack{
            CheckBoxView(completeDate: completeDate, id: id,dateHolder: dateHolder)


            Text(name ?? "")
                .padding(.horizontal)

            if !isCompleted() && scheduleTime {
                Spacer()
                Text(dueDateTimeOnly())
                    .font(.footnote)
                    .foregroundColor(overDueColor())
                    .padding(.horizontal)
            }
        }
    }
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

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(name: "aaa",completeDate: nil, id: UUID().uuidString, scheduleTime: false, dueDate: Date(),dateHolder: DateHolder())
    }
}
