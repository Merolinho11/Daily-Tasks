

import SwiftUI

// MARK: VIEW WITH THE TASK DETAILS

struct TaskDetailsView: View {
    
    let task: TaskEntity
    
    @EnvironmentObject private var vm: CoreDataViewModel
    
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationView {
            VStack (spacing: 30) {
                
                Text(task.title ?? "")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack {
                    Text(task.category ?? "")
                    switch task.category {
                    case "Entertainment": Text("\(images[0])")
                    case "Study": Text("\(images[1])")
                        case "Work": Text("\(images[3])")
                    default: Text("\(images[2])")
                    }
                    
                    // controls on startMinute and endMinute before their display
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
                .font(.headline)
                
                if task.info != "" {
                    Text(task.info ?? "No info")
                        .padding()
                        .font(.body)
                        .border(.brown)
                }
                
                Button {
                    showModal = true
                } label: {
                    Text("Edit")
                        .frame(width: 70, height: 30)
                        .background(.white, in: RoundedRectangle (cornerRadius: 20))
                        .foregroundColor(.blue)
                } .sheet(isPresented: $showModal) {
                    EditView(task: task)
                }
                
                Spacer()
                
            }
        }
    }
}
