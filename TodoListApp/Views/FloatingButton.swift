//
//  FloatingButton.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/07/21.
//

import SwiftUI

struct FloatingButton: View {
    @EnvironmentObject var dateHolder: DateHolder

    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                NavigationLink(destination: TaskEditView(name: nil, desc: nil, dueDate: nil,scheduleTime: nil, id: nil, completeDate: nil, initialDate: Date())
                    .environmentObject(dateHolder)){
                    Text("+ New Task")
                        .font(.headline)
                }
                .padding(15)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(30)
                .padding(30)
                .shadow(color: .black.opacity(0.3), radius: 3,x:3,y:3)
            }
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
