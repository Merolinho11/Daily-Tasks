//
//  ContentView.swift
//  TiMe
//
//  Created by Francesco Merola on 13/12/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @EnvironmentObject var vm: CoreDataViewModel
    
    @EnvironmentObject var day: ChosenDay
    
    var body: some View {
        NavigationView {
            VStack {
                TaskListView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let vm = CoreDataViewModel()
    static let day = ChosenDay()
    
    static var previews: some View {
        ContentView()
            .environmentObject(vm)
            .environmentObject(day)
    }
}
