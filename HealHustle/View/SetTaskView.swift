//
//  SetTaskView.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 23/07/22.
//

import SwiftUI

struct SetTaskView: View {
    
    @State private var isShowingModal: Bool = false
    @State var selectedProdType = 0
    
    
    //For list
    @EnvironmentObject var taskStore: TaskStore
    
    //For timer
    @AppStorage("TIME_AMOUNT") var timeAmount: Int = 0
    @AppStorage("BREAK_TIME") var breakTime: Int = 0
    @AppStorage("PROD_TYPE") var prodType: String = "LONG"
    @AppStorage("PROD_NAME") var prodName: String = "Ultradian Rhytms"
    //For Task Array Validation
    @State var taskArrayValidation = false
    //PopToRoot
    @Binding var rootIsActive: Bool

    var body: some View {
            ZStack {
                Color("Cream")
                    .ignoresSafeArea()
                VStack {
                    Text("Set Your Task")
                        .font(.system(size: 34))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("DarkGrey"))
                    
                    Picker(selection: $selectedProdType, label:
                            Text("Select Productivity Type")
                    ) {
                        HStack (spacing: 10) {
                            Image(systemName: "clock.fill")
                            Text("LONG (90m Work & 20m Break)")
                                .foregroundColor(Color("Grey"))
                        }
                        .tag(0)
                        HStack (spacing: 10){
                            Image(systemName: "clock.circle")
                            Spacer()
                            Text("MEDIUM (52m Work & 17m Break)")
                                .foregroundColor(Color("Grey"))
                        }
                        .tag(1)
                        HStack (spacing: 10){
                            Image(systemName: "clock")
                            Spacer()
                            Text("SHORT (25m Work & 5m Break)")
                                .foregroundColor(Color("Grey"))
                        }
                        .tag(2)
                    }
                    .onReceive([self.selectedProdType].publisher.first()) { value in
                        if value == 0 {
                            breakTime = 1200
                            timeAmount = 5
                            prodType = "LONG"
                            prodName = "Ultradian Rhytms"
                        } else if value == 1 {
                            breakTime = 1060
                            timeAmount = 3120
                            prodType = "MEDIUM"
                            prodName = "Desktime Variation"
                        } else if value == 2 {
                            breakTime = 300
                            timeAmount = 1500
                            prodType = "SHORT"
                            prodName = "Pomodoro Technique"
                        }
                    }
                    .frame(width: 279, height: 55, alignment: .center)
                    .font(.system(size: 23).bold())
                    .foregroundColor(Color("Orange"))
                    .background(Color("Green"))
                    .cornerRadius(20)
                    .shadow(color: Color("DarkGrey").opacity(0.7), radius: 15)
                    
                    HStack {
                        Button {
                            isShowingModal.toggle()
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
                        
                        if !taskStore.tasks.isEmpty {
                            NavigationLink {
                                //TimerView(endRunning: $endRunning)
                                TimerView(rootIsActive: self.$rootIsActive)
                            } label: {
                                HStack {
                                    Image(systemName: "play.square.fill")
                                        .font(.system(size: 23))
                                        .foregroundColor(Color("Orange"))
                                    Text("Start")
                                        .font(.system(size: 23))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("Orange"))
                                }
                            }
                            .isDetailLink(false)
                            .frame(width: 134, height: 55)
                            .background(Color("Green"))
                            .cornerRadius(20)
                            .shadow(color: Color("DarkGrey").opacity(0.7), radius: 15)
                        }
                    }
                    .offset(y: 5)
                    
                    List {
                        ForEach(taskStore.tasks) { task in
                            VStack(alignment: .leading) {
                                Text(task.taskItem)
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Green"))
                                Text(task.taskDetail)
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("DarkGrey"))
                            }
                            .listRowBackground(Color("Cream"))
                        }
                        .onDelete(perform: self.delete)
                    }
                    .offset(y: 25)
                    .listStyle(.plain)
                    
                   
                }
                .offset(y: -50)
                .onChange(of: taskStore.tasks) { _ in
                    if taskStore.tasks.isEmpty {
                        taskArrayValidation = false
                    } else {
                        taskArrayValidation = true
                    }
                }
                
            }
            .sheet(isPresented: $isShowingModal, onDismiss: didDismiss) {
                InputTaskModalView().environmentObject(taskStore)
            }
            
        
    }
    
    
    func delete(at offsets: IndexSet) {
        taskStore.tasks.remove(atOffsets: offsets)
    }
}

private extension SetTaskView {
    func didDismiss() {
        print("Dismissed View")
    }
}

struct SetTaskView_Previews: PreviewProvider {
    static var previews: some View {
//        SetTaskView()
//            .environmentObject(TaskStore())
        SetTaskView(rootIsActive: .constant(true))
            .environmentObject(TaskStore())
    }
}
