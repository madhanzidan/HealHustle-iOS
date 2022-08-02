//
//  TaskListModalView.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 27/07/22.
//

import SwiftUI

struct TaskListModalView: View {
    
    @Binding var isShowing: Bool
    @State private var isDragging = false
    @State private var curHeight: CGFloat = 400
    let minHeight: CGFloat = 400
    let maxHeight: CGFloat = 700
    let startOpacity: Double = 0.4
    let endOpacity: Double = 0.8
    
    //For list
    @EnvironmentObject var taskStore: TaskStore
    
    @State var selectedIdx: Int = 0
    
    var dragPercentage: Double{
        let res = Double((curHeight - minHeight) / (maxHeight - minHeight))
        return max(0, min(1, res))
    }
    
    var body: some View {
        ZStack (alignment: .bottom){
            if isShowing {
                Color.black
                    .ignoresSafeArea()
                    .opacity(startOpacity + (endOpacity - startOpacity) * dragPercentage)
                    .onTapGesture {
                        isShowing = false
                    }
                
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
    }
    
    var mainView: some View {
        VStack {
            
            ZStack {
                Capsule()
                    .frame(width: 40, height: 6)
                    .foregroundColor(Color("DarkGrey"))
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            
            ZStack {
                VStack {
                    List {
                        ForEach(taskStore.tasks, id: \.id) { (task) in
                            HStack {
                                    Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                                    .foregroundColor(Color("Green"))
                                        .onTapGesture {
                                            updatevalue(idx: Int(task.id )! - 1)
                                        }
                                    VStack(alignment: .leading) {
                                        Text(task.taskItem)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("Green"))
                                        Text(task.taskDetail)
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("DarkGrey"))
                                    }
                            }
                            .listRowBackground(Color("Cream"))
                        }
                        .onDelete(perform: self.delete)
                    }
                    
                    .listStyle(.plain)
                }
                .padding(.horizontal, 30)
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
        }
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: curHeight/2)
            }
            .foregroundColor(Color("Cream"))
        )
        .animation(isDragging ? nil : .easeInOut(duration: 0.45))
        .onDisappear { curHeight = minHeight }
    }
    
    func updatevalue(idx: Int){
        print(taskStore)
        taskStore.tasks[idx].isCompleted.toggle()
        selectedIdx += 1
    }
    
    func delete(at offsets: IndexSet) {
        taskStore.tasks.remove(atOffsets: offsets)
    }
    
    @State private var prevDragTranslation = CGSize.zero
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { value in
                if !isDragging {
                    isDragging = true
                }
                let dragAmount = value.translation.height - prevDragTranslation.height
                
                if curHeight > maxHeight || curHeight < minHeight {
                    curHeight -= dragAmount / 6
                } else {
                    curHeight -= dragAmount
                }
                prevDragTranslation = value.translation
            }
            .onEnded { value in
                prevDragTranslation = .zero
                isDragging = false
                
                if curHeight > maxHeight {
                    curHeight = maxHeight
                } else if curHeight < minHeight {
                    curHeight = minHeight
                }
            }
    }
}

struct TaskListModalView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(endRunning: false, rootIsActive: .constant(false))
    }
}
