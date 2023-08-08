//
//  DateScroller.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/07/21.
//

import SwiftUI

struct DateScroller: View {
    @EnvironmentObject var dateHolder: DateHolder

    var body: some View {
        HStack{
            Spacer()
            Button(action: moveBack){
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .font(Font.title.weight(.bold))
            }
            Text(dateFormatted())
                .font(.title)
                .bold()
                .animation(.none)
                .frame(maxWidth:.infinity)
            Button(action: moveForward){
                Image(systemName: "arrow.right")
                    .imageScale(.large)
                    .font(Font.title.weight(.bold))
            }
        }
    }

    func dateFormatted() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.LL.dd"
        return dateFormatter.string(from: dateHolder.date)

    }

    func moveBack(){
        withAnimation{
            dateHolder.moveDate(-1)
        }
    }
    func moveForward(){
        withAnimation{
            dateHolder.moveDate(1)
        }
    }
}

struct DateScroller_Previews: PreviewProvider {
    static var previews: some View {
        DateScroller()
    }
}
