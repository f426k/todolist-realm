//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/07/21.
//

import SwiftUI

@main
struct TodoListAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
