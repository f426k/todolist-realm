//
//  ContentView.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/07/21.
//

import SwiftUI
import RealmSwift

struct TaskListView: View {
    @EnvironmentObject var dateHolder: DateHolder
    @State var selectedFilter = TaskFilter.NonCompleted

    var body: some View {
        NavigationView {
            VStack{
                DateScroller()
                    .padding()
                    .environmentObject(dateHolder)
                ZStack{
                    List {
                        ForEach(filteredTaskItems()) { taskItem in
                            NavigationLink(destination:
                                            TaskEditView(
                                                name: taskItem.name,
                                                desc: taskItem.desc,
                                                dueDate: taskItem.dueDate,
                                                scheduleTime: taskItem.scheduleTime,
                                                id: taskItem.id,
                                                completeDate: taskItem.completeDate,
                                                initialDate: taskItem.dueDate!,
                                                dateHolder: dateHolder
                                            )
                            )
                            {
                                TaskCell(
                                    name: taskItem.name,
                                    completeDate: taskItem.completeDate,
                                    id: taskItem.id,
                                    scheduleTime: taskItem.scheduleTime,
                                    dueDate: taskItem.dueDate,
                                    dateHolder: dateHolder
                                )
                                    
                            }.id(UUID())
                        }
//                        .onDelete {IndexSet in
//                            withAnimation {
//                                filteredTaskItems().remove(atOffsets: IndexSet)
//                            }
//                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Picker("", selection: $selectedFilter.animation()) {
                                ForEach(TaskFilter.allFilters,id:\.self){
                                    filter in
                                    Text(filter.rawValue)
                                }
                            }
                        }
                    }
                    FloatingButton(dateHolder: dateHolder)
                }
            }
            .navigationTitle("To Do List")
        }
    }

    private func filteredTaskItems() -> [Task] {
        let result = dateHolder.taskItems.filter{!$0.isInvalidated}
        if selectedFilter == TaskFilter.Completed{
            return result.filter{$0.isCompleted()}
        }
        if selectedFilter == TaskFilter.NonCompleted{
            return result.filter{!$0.isCompleted()}
        }
        if selectedFilter == TaskFilter.OverDue{
            return result.filter{$0.isOverdue()}
        }
        return result
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
