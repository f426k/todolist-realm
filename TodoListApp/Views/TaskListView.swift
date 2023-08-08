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
                                                desc: taskItem.desc, dueDate: taskItem.dueDate,
                                                scheduleTime: taskItem.scheduleTime,
                                                id: taskItem.id,
                                                completeDate: taskItem.completeDate,
                                                initialDate: taskItem.dueDate!
                                            )
                                                .environmentObject(dateHolder)) {
                                                    TaskCell(passedTaskItem: taskItem)
                                                        .environmentObject(dateHolder)
                                                }
                        }
//                        .onDelete {IndexSet in
//                            withAnimation {
//                                filteredTaskItems().remove(atOffsets: IndexSet)
//                            }
//                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Picker("", selection: $selectedFilter.animation()){
                                ForEach(TaskFilter.allFilters,id:\.self){
                                    filter in
                                    Text(filter.rawValue)
                                }
                            }
                        }
                    }
                    FloatingButton()
                        .environmentObject(dateHolder)
                }
            }
            .navigationTitle("To Do List")
        }
    }

    private func filteredTaskItems() -> [Task] {
        if selectedFilter == TaskFilter.Completed{
            return dateHolder.taskItems.filter{$0.isCompleted()}
        }
        if selectedFilter == TaskFilter.NonCompleted{
            return dateHolder.taskItems.filter{!$0.isCompleted()}
        }
        if selectedFilter == TaskFilter.OverDue{
            return dateHolder.taskItems.filter{$0.isOverdue()}
        }
        return dateHolder.taskItems
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
