//
//  SuccessView.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 28/07/22.
//

import SwiftUI

struct SuccessView: View {
    //For list
    @EnvironmentObject var taskStore: TaskStore
    @AppStorage("TOTAL_POINTS") var totalPoints: Int = 0
    
    var body: some View {
        ZStack {
            Color("DarkGrey")
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("CONGRATULATION,\nYOU GOT +10 PTS")
                        .font(.system(size: 33))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Orange"))
                    Text("Let's do it again!")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                        .foregroundColor(Color("White"))
                }
                .offset(y: -30)
                Image("Coin")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .center)
                    .padding()
                    .offset(y: -20)
                

                Button {
                    taskStore.tasks.removeAll()
                    totalPoints += 10
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
        }
        .navigationBarHidden(true)
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
