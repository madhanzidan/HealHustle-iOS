//
//  TimerView.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 23/07/22.
//

import SwiftUI
import AVKit

struct TimerView: View {
    
    @AppStorage("PROD_TYPE") var prodTypeLabel: String = ""
    @AppStorage("PROD_NAME") var prodNameLabel: String = ""
    @State private var presentBreakView = false
    @State private var showModal = false
    
    @State var endRunning: Bool = false
    
    //For list
    @EnvironmentObject var taskStore: TaskStore

    
    //PopToRoot
    @Binding var rootIsActive: Bool
    
    var body: some View {
        ZStack {
            Color("Green")
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text(prodTypeLabel)
                        .font(.system(size: 48))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("Orange"))
                    Text(prodNameLabel)
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                        .foregroundColor(Color("White"))
                }
                .offset(y: -50)
                CircularTimer(endRunning: $endRunning)
                
                
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(Color("Grey"))
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        .frame(height: 150)
                        .ignoresSafeArea()
                        .shadow(color: Color("Orange").opacity(1), radius: 30)
                    
                    VStack {
                        Button {
                            showModal = true
                        } label: {
                            HStack {
                                Image(systemName: "list.bullet.rectangle.fill")
                                    .font(.system(size: 23))
                                    .foregroundColor(Color("Orange"))
                                Text("Task List")
                                    .font(.system(size: 23))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Orange"))
                            }
                        }
                        .frame(width: 276, height: 55)
                        .background(Color("Green"))
                        .cornerRadius(20)
                        .shadow(color: Color("DarkGrey").opacity(0.7), radius: 15)
                        
                        //MARK: - Timer
                        if endRunning {
                            NavigationLink {
                                BreakTimeView()
                            } label: {
                                HStack {
                                    Image(systemName: "heart.square.fill")
                                        .font(.system(size: 23))
                                        .foregroundColor(Color("Green"))
                                    Text("Let's Healing")
                                        .font(.system(size: 23))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("Green"))

                                }
                                .frame(width: 276, height: 55)
                                .background(Color("Orange"))
                                .cornerRadius(20)
                                .shadow(color: Color("Orange").opacity(0.7), radius: 15)
                                
                            }
                        } else {
                            NavigationLink {
                                FailView(popToRoot: self.$rootIsActive)
                            } label: {
                                HStack {
                                    Image(systemName: "xmark.square.fill")
                                        .font(.system(size: 23))
                                        .foregroundColor(Color("Orange"))
                                    Text("End Session")
                                        .font(.system(size: 23))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("Orange"))
                                }
                                .frame(width: 276, height: 55)
                                .background(Color("DarkGrey"))
                                .cornerRadius(20)
                                .shadow(color: Color("DarkGrey").opacity(0.7), radius: 15)
                            }
                            .isDetailLink(false)
                        }

                    }
                    
                }
            }
            TaskListModalView(isShowing: $showModal)//.environmentObject(taskStore)
        }
        .accentColor(Color("White"))
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(endRunning: true, rootIsActive: .constant(false))
    }
}
