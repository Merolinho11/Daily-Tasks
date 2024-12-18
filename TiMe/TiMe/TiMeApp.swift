

import SwiftUI

@main
struct TiMeApp: App {

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
