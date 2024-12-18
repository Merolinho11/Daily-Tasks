
import SwiftUI
import CoreData

// MARK: VIEW THAT ALLOWS TO INSERT A NEW TASK

struct AddView: View {
    
    @EnvironmentObject private var vm: CoreDataViewModel
    
    @State private var showModal: Bool = true
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var titleEntered = ""
    @State private var infoEntered = ""
    @State private var dayEntered = "MO"
    @State private var categoryEntered = "Entertainment"
    @State private var startHourEntered: Int16 = 12
    @State private var startMinuteEntered: Int16 = 30
    @State private var endHourEntered: Int16 = 13
    @State private var endMinuteEntered: Int16 = 30
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Title", text: $titleEntered, axis:.vertical)
                    }
                    
                    Section {
                        TextField("Info", text: $infoEntered, axis: .vertical)
                    }
                    
                    Section {
                        Picker ("Category", selection: $categoryEntered) {
                            ForEach(categories, id: \.self) { category in
                                Text("\(category)").tag(0)
                                
                            }
                        }
                        
                        Picker ("Day", selection: $dayEntered) {
                            ForEach(days, id: \.self) { day in
                                Text("\(day)")
                            }
                        }
                    }
                    
                    Section {
                        
                        VStack {
                            HStack {
                                Picker ("Hour", selection: $startHourEntered) {
                                    ForEach(hours, id: \.self) { startHour in
                                        Text("\(startHour)").tag(0)
                                    }
                                }
                                
                                Picker ("Minutes", selection: $startMinuteEntered) {
                                    ForEach(minutes, id: \.self) { startMinute in
                                        Text("\(startMinute)").tag(0)
                                    }
                                }
                            }
                        }
                    }
                    header : {
                        Text("Start time")
                    }
                    
                    Section {
                        VStack {
                            HStack {
                                Picker ("Hour", selection: $endHourEntered) {
                                    ForEach(hours, id: \.self) { endHour in
                                        Text("\(endHour)").tag(1)
                                    }
                                }
                                
                                Picker ("Minutes", selection: $endMinuteEntered) {
                                    ForEach(minutes, id: \.self) { endMinute in
                                        Text("\(endMinute)").tag(0)
                                    }
                                }
                            }
                        }
                    }
                    header : {
                        Text("End time")
                    }
                }
            }.navigationTitle("Add Task")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems (trailing:  Button("Save") {
                    vm.addTask(title: titleEntered, info: infoEntered, startHour: startHourEntered, endHour: endHourEntered, endMinute: endMinuteEntered, startMinute: startMinuteEntered, category: categoryEntered, day: dayEntered)
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
