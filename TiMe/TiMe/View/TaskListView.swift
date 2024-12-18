
import SwiftUI

// MARK: VIEW THAT PRESENTS THE LIST OF THE TASKS, UNDER THE DAYS PICKER

struct TaskListView: View {
    
    @EnvironmentObject private var vm: CoreDataViewModel
    
    @EnvironmentObject var day: ChosenDay
    
    @State var showModal: Bool = false
    
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                WeekView()
                List {
                    ForEach(vm.savedEntities.filter {$0.day == day.chosenDay}, id: \.self) { task in
                        NavigationLink (destination: TaskDetailsView(task: task)) {
                            
                            HStack {
                                Text(task.title ?? "No title")
                                    .fontWeight(.bold)
                                Spacer()
                                
                                if task.startMinute == 00 && task.endMinute != 00 {
                                    Text("\(task.startHour) - \(task.endHour):\(task.endMinute)")
                                } else if task.startMinute != 0 && task.endMinute != 00 {
                                    Text("\(task.startHour):\(task.startMinute) - \(task.endHour):\(task.endMinute)")
                                } else if task.startMinute != 00 && task.endMinute == 0 {
                                    Text("\(task.startHour):\(task.startMinute) - \(task.endHour)")
                                } else if task.startMinute == 0 && task.endMinute == 00 {
                                    Text("\(task.startHour) - \(task.endHour)")
                                }
                            }
                            
                        }
                        
                    }.onDelete(perform: vm.deleteTask)
                }.listStyle(InsetGroupedListStyle())
                    .navigationTitle("My Calendar")
                VStack {
                    // VStack added to avoid compilation error
                }
                .toolbar {
                    ToolbarItemGroup (placement: .bottomBar) {
                        Button("Clean Calendar") {
                            
                            // display an alert only if there are tasks in the list
                            
                            if vm.savedEntities.count != 0 {
                                showAlert = true
                            }
                        }
                        .accessibilityLabel("Clean Calendar")
                        .accessibilityHint("Touch it to cancel all your tasks")
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("ALERT 🚨"),
                          message: Text("Are you sure to delete all your tasks?"),
                          primaryButton: .default(Text("Cancel")) {
                        showAlert = false
                    },
                          secondaryButton: .default(Text("Yes")) {
                        vm.deleteAllTasks()
                    })
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showModal = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                    } .sheet(isPresented: $showModal) {
                        AddView()
                    }
                }
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    
    static let vm = CoreDataViewModel()
    
    static let day = ChosenDay ()
    
    static var previews: some View {
        TaskListView()
            .environmentObject(vm)
            .environmentObject(day)
    }
}
