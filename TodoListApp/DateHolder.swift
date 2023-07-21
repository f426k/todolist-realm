//
//  DateHolder.swift
//  TodoListApp
//
//  Created by Fuka Takashima on 2023/07/21.
//

import SwiftUI
import CoreData

class DateHolder: ObservableObject{
    @Published var date = Date()

    let calendar: Calendar = Calendar.current

    func moveDate(_ days:Int,_ context: NSManagedObjectContext){
        date = calendar.date(byAdding: .day, value: days, to: date)!
    }

    init(_ context: NSManagedObjectContext){
        
    }
    func saveContext(_ context: NSManagedObjectContext){
       do {
           try context.save()
       } catch {
           let nsError = error as NSError
           fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
       }
   }
}
