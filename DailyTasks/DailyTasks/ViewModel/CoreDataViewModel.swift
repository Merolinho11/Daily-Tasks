import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var savedEntities: [TaskEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "TiMe")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        fetchTasks()
    }
    
    func fetchTasks() {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addTask(title: String, info: String, startHour: Int16, endHour: Int16, endMinute: Int16, startMinute: Int16, category: String, day: String) {
        
        let newTask = TaskEntity(context: container.viewContext)
        newTask.title = title
        newTask.info = info
        newTask.startHour = startHour
        newTask.endHour = endHour
        newTask.startMinute = startMinute
        newTask.endMinute = endMinute
        newTask.category = category
        newTask.day = day
        
        saveData()
    }
    
    func deleteTask (indexSet:IndexSet) {
        
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        
        saveData()
    }
    
    func deleteAllTasks() {
        
        for entity in savedEntities {
            container.viewContext.delete(entity)
        }
        
        saveData()
    }
    
    func updateTask(task: TaskEntity, title: String, info: String, day: String, category: String, startHour: Int16, startMinute: Int16, endHour: Int16, endMinute: Int16) {
        
        // Update the properties of the given task with the new values
        
        task.title = title
        task.info = info
        task.day = day
        task.category = category
        task.startHour = startHour
        task.startMinute = startMinute
        task.endHour = endHour
        task.endMinute = endMinute
        
        // Save the changes to Core Data
        
        saveData()
       
    }
    
    func saveData () {
        
        do {
            try container.viewContext.save()
            fetchTasks()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
}
