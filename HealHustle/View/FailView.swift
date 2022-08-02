//
//  FailView.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 27/07/22.
//

import SwiftUI

struct FailView: View {
    //PopToRoot
    @Binding var popToRoot: Bool
    //For list
    @EnvironmentObject var taskStore: TaskStore
    
    var body: some View {
        ZStack {
            Color("DarkGrey")
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("SORRY,\nNO POINTS FOR YOU")
                        .font(.system(size: 33))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Orange"))
                    Text("Let's do better next time")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                        .foregroundColor(Color("White"))
                }
                .offset(y: -30)
                Image("SadWoman")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .center)
                    .padding()
                Button {
                    self.popToRoot = false
                    taskStore.tasks.removeAll()
                } label: {
                    Text("End")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Green"))
                        .frame(width: 134, height: 55)
                        .background(Color("Orange"))
                        .cornerRadius(20)
                        .shadow(color: Color("Orange").opacity(0.7), radius: 15)
                        .offset(y: 5)
                }
            }
        }.navigationBarHidden(true)
    }
}

struct FailView_Previews: PreviewProvider {
    static var previews: some View {
        FailView(popToRoot: .constant(true))
    }
}
