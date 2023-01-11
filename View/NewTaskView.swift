import SwiftUI

struct NewTaskView: View {
    @Binding var isShow: Bool
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var taskName: String = ""
    @State private var taskPriority: Priority = .normal
    @State private var isEditing: Bool = false // to track if TextField is being editit or not
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Add new task")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.isShow = false
                    }) { 
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(self.taskPriority.priorityColor())
                    } //: Button
                } //: HStack
                
                TextField("New task description", text: self.$taskName, onEditingChanged: { self.isEditing = $0 })
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom)
                
                Text("Priority")
                    .fontWeight(.semibold)
                
                HStack {
                    PriorityView(priorityTitle: "High", selectedPriority: self.$taskPriority)
                        .onTapGesture { self.taskPriority = .high }
                    
                    PriorityView(priorityTitle: "Normal", selectedPriority: self.$taskPriority)
                        .onTapGesture { self.taskPriority = .normal }
                    
                    PriorityView(priorityTitle: "Low", selectedPriority: self.$taskPriority)
                        .onTapGesture { self.taskPriority = .low }
                } //: HStack
                
                Button (action: {
                    // to make sure that task description is not empty
                    guard self.taskName.trimmingCharacters(in: .whitespaces) != "" else { return }
                    
                    self.isShow = false
                    self.addNewTask(name: self.taskName, priority: self.taskPriority)
                }) { 
                    Text("Add new task")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(self.taskPriority.priorityColor())
                } //: Button
                .cornerRadius(10)
                .padding(.vertical)
            } //: VStack
            .padding()
            .background(Color.white)
            .cornerRadius(10, antialiased: true)
            .offset(y: self.isEditing ? -320 : 0) // to prevent the system keyboard to overlay on this view
        } //: VStack
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func addNewTask(name: String, priority: Priority) -> Void {
        let newTask = Task(context: viewContext)
        newTask.id = UUID()
        newTask.name = name
        newTask.priority = priority
        newTask.complete = false
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(isShow: .constant(true))
    }
}
