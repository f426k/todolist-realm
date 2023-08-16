//
//  TaskEditView.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/07/21.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    var dateHolder: DateHolder

    @State var name: String
    @State var desc: String
    @State var dueDate: Date
    @State var scheduleTime: Bool
    var completeDate: Date?
    var id: String

    init(name: String?, desc:String?, dueDate:Date?, scheduleTime:Bool?, id:String?, completeDate:Date?, initialDate: Date, dateHolder: DateHolder){
        if id != nil {
            _name = State(initialValue: name ?? "")
            _desc = State(initialValue: desc ?? "")
            _dueDate = State(initialValue: dueDate ?? initialDate)
            _scheduleTime = State(initialValue: scheduleTime ?? false)
            self.id = id ?? ""
            self.completeDate = completeDate ?? nil
            self.dateHolder = dateHolder
        } else {
            _name = State(initialValue: "")
            _desc = State(initialValue: "")
            _dueDate = State(initialValue: initialDate)
            _scheduleTime = State(initialValue: false)
            self.id = ""
            self.completeDate =  nil
            self.dateHolder = dateHolder
        }
    }

    var body: some View
    {
        Form
        {
            Section(header: Text("Task"))
            {
                TextField("Task Name", text: $name)
                TextField("Desc", text: $desc)
            }

            Section(header: Text("Due Date"))
            {
                Toggle("Schedule Time", isOn: $scheduleTime)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: displayComps())
                    .environment(\.locale, Locale(identifier: "ja_JP"))
            }

            if completeDate != nil {
                Section(header: Text("Completed"))
                {
                    Text(completeDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                        .foregroundColor(.green)
                }
            }

            Section()
            {
                Button("Save", action: {try! saveAction()})
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                
            if id != "" {
                Button("Delete", action: {try! deleteAction()})
                    .font(.headline)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationTitle("Task Detail")
    }

    func displayComps() -> DatePickerComponents {
        return scheduleTime ? [.hourAndMinute, .date]: [.date]
    }

    func saveAction() throws {
        try TaskService.shared.createTask(name: name, desc: desc, scheduleTime: scheduleTime, dueDate: dueDate, id: id)
        self.presentationMode.wrappedValue.dismiss()
        dateHolder.refreshTaskItems()
    }

    func deleteAction() throws {
        try TaskService.shared.deleteTask(id: id)
        dateHolder.refreshTaskItems()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(name: "test", desc: "aaaa", dueDate: Date(), scheduleTime: false, id: "", completeDate: nil, initialDate: Date(), dateHolder: DateHolder())
    }
}
