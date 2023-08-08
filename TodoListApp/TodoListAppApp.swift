//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/07/21.
//

import SwiftUI

@main
struct TodoListAppApp: App {

    var body: some Scene {
        WindowGroup {
            let dateHolder = DateHolder()

            TaskListView()
                .environmentObject(dateHolder)
        }
    }
}
