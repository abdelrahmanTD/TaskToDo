import SwiftUI
import CoreData

// Create Core Data class for Task entity
@objc(Task)
public class Task: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var complete: Bool
    @NSManaged public var priorityNum: Int32
}

extension Task: Identifiable {
    var priority: Priority {
        get {
            Priority(rawValue: Int(priorityNum)) ?? .normal
        }
        
        set {
            self.priorityNum = Int32(newValue.rawValue)
        }
    }
}

enum Priority: Int {
    case low = 0
    case normal = 1
    case high = 2
    
    var priorityType: String {
        switch rawValue {
            case Priority.low.rawValue: return "low"
            case Priority.normal.rawValue: return "normal"
            case Priority.high.rawValue: return "high"
            
            default: return ""
        }
    }
    
    // to set color for each type of priorities
    func priorityColor() -> Color {
        switch rawValue {
            case Priority.low.rawValue: return .green
            case Priority.normal.rawValue: return .orange
            case Priority.high.rawValue: return .red
            
            default: return .orange
        }
    }
}
