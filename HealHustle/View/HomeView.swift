//
//  ContentView.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 21/07/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Cream")
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color("Green"))
                            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                            .frame(height: 172)
                            .ignoresSafeArea()
                            .shadow(color: Color("Orange").opacity(1), radius: 30)
                        Text("Hello,\nLet’s start your hustle!")
                            .font(.system(size: 33))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("Orange"))
                            .offset(y: -35)
                    }
                    Spacer()
                    
                    NavigationLink(
                        destination: SetTaskView(rootIsActive: self.$isActive)
                        ,
                        isActive: self.$isActive
                    ) {
                        Image("HomeStartButton")
                            .resizable()
                            .frame(width: 326, height: 325, alignment: .center)
                            .padding()
                            .offset(y: -110)
                    }
                    .isDetailLink(false)
                    
                    
                }
            }
            .navigationTitle("Hustle")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        .accentColor(Color("Orange"))
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
