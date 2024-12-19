//
//  ThursdayListView.swift
//  TiMe
//
//  Created by Francesco Merola on 14/12/22.
//

import SwiftUI

struct ThursdayListView: View {
    
    @EnvironmentObject private var vm: CoreDataViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                WeekView()
                List {
                    ForEach(vm.savedEntities.filter {$0.day == "TH"}, id: \.self) { task in
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

//struct ThursdayListView_Previews: PreviewProvider {
//    
//    static let vm = CoreDataViewModel()
//    
//    static var previews: some View {
//        ThursdayListView().environmentObject(vm)
//    }
//}
