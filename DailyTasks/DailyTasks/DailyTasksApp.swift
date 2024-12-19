//
//  DailyTasksApp.swift
//  DailyTasks
//
//  Created by Matteo Merola on 19/12/24.
//

import SwiftUI

@main
struct DailyTasksApp: App {
    
    @StateObject var vm = CoreDataViewModel()
    
    @StateObject var day = ChosenDay()
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environmentObject(vm)
                .environmentObject(day)
        }
    }
}
