//
//  InputTaskModalView.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 25/07/22.
//

import SwiftUI

enum TaskType {
    case quickWins, majorProjects, fillIns, thankless
}

struct InputTaskModalView: View {
    @Environment(\.dismiss) private var dismiss
    
    //For textField
    @EnvironmentObject var taskStore: TaskStore
    @State var newTask: String  = ""
    @State var priorityChoosed: TaskType = TaskType.quickWins
    
    //TextField validation
    @State var textFieldValidation: Bool = false
    @State var presentAlert = false
    
    var priorityTypeName: String {
        switch priorityChoosed {
        case .quickWins:
            return "QUICK WINS"
        case .majorProjects:
            return "MAJOR PROJECT"
        case .fillIns:
            return "FILL-INS"
        case .thankless:
            return "THANKLESS TASKS"
        }
    }
    
    
    var body: some View {
        ZStack {
            Color("Cream")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Input What To Do")
                    .font(.system(size: 23))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Green"))
                    .offset(y: -65)
                
                TextField("Let's hustle...", text: $newTask)
                    .padding()
                    .background(Color("White"))
                    .frame(width: 350, height: 42, alignment: .center)
                    .cornerRadius(10)
                    .shadow(color: Color("Green").opacity(0.3), radius: 10)
                    .offset(y: -60)
                    .submitLabel(.done)
                Text("Select Task Priority")
                    .font(.system(size: 23))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Green"))
                    .offset(y: -50)
                
                Picker("Priority Type", selection: $priorityChoosed) {
                    HStack {
                        Image(systemName: "dial.max.fill")
                        Text("QUICK WINS")
                    }.tag(TaskType.quickWins)
                    HStack {
                        Image(systemName: "dial.min.fill")
                        Text("MAJOR PROJECT")
                    }.tag(TaskType.majorProjects)
                    
                    HStack {
                        Image(systemName: "dial.max")
                        Text("FILL-INS")
                    }.tag(TaskType.fillIns)
                    
                    HStack {
                        Image(systemName: "dial.min")
                        Text("THANKLESS TASKS")
                    }.tag(TaskType.thankless)
                }
                .padding()
                .background(Color("White"))
                .frame(width: 350, alignment: .center)
                .cornerRadius(10)
                .shadow(color: Color("Green").opacity(0.3), radius: 10)
                .pickerStyle(.wheel)
                .offset(y: -50)
                
                Button {
                    if textFieldValidation == true {
                        addNewTask()
                        dismiss()
                    } else {
                        presentAlert = true
                    }
                    
                } label: {
                    HStack {
                        Image(systemName: "plus.square.fill")
                            .font(.system(size: 23))
                            .foregroundColor(Color("Orange"))
                        Text("Add")
                            .font(.system(size: 23))
                            .fontWeight(.bold)
                            .foregroundColor(Color("Orange"))
                    }
                }
                .frame(width: 134, height: 55)
                .background(Color("Green"))
                .cornerRadius(20)
                .shadow(color: Color("DarkGrey").opacity(0.7), radius: 15)
                .offset(y: -40)
            }
            .alert("You need to input the task!", isPresented: $presentAlert) {
            }
            .onChange(of: newTask) { _ in
                if newTask == "" {
                    textFieldValidation = false
                } else {
                    textFieldValidation = true
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            close
        }
    }
    
    func addNewTask() {
        taskStore.tasks.append(Task(id: String(taskStore.tasks.count + 1), taskItem: newTask, taskDetail: priorityTypeName, isCompleted: false))
        self.newTask = ""
    }

}


struct InputTaskModalView_Previews: PreviewProvider {
    static var previews: some View {
        InputTaskModalView()
    }
}


private extension InputTaskModalView {
    var close: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .font(.largeTitle)
                .foregroundColor(Color("Green"))
        }
        .padding()

    }
}
