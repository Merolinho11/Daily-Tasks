//
//  FridayListView.swift
//  TiMe
//
//  Created by Francesco Merola on 14/12/22.
//

import SwiftUI

struct FridayListView: View {
    
    @EnvironmentObject private var vm: CoreDataViewModel
    
    @State var bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                WeekView()
                List {
                    ForEach(vm.savedEntities.filter {$0.day == "FR"}) { task in
                            NavigationLink (destination: TaskDetailsView(task: task)) {
                                
                                HStack {
                                    Text(task.title ?? "No title")
                                        .fontWeight(.bold)
                                    Spacer()
                                    Text("\(task.startHour):\(task.startMinute) - \(task.endHour):\(task.endMinute)")
                                }
                            }
                        
                    }.onDelete(perform: vm.deleteTask)
                    
                }
            }.navigationBarTitle("My Calendar")
        }
    }
}

//struct FridayListView_Previews: PreviewProvider {
//    
//    static let vm = CoreDataViewModel()
//    
//    static var previews: some View {
//        FridayListView().environmentObject(vm)
//    }
//}
