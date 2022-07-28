//
//  PointsView.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 23/07/22.
//

import SwiftUI

struct PointsView: View {
    @AppStorage("TOTAL_POINTS") var totalPoints: Int = 0
    
    var body: some View {
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
                    Text("Here's your total\npoints!")
                        .font(.system(size: 34))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("Orange"))
                        .padding()
                        .offset(x: -35)
                        .offset(y: 15)
                }
                .offset(y: 20)
                VStack {
                    Text(String(totalPoints))
                        .font(.system(size: 100))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("DarkGrey"))
                        .offset()
                    Text("Points")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                        .foregroundColor(Color("DarkGrey"))
                        .offset(y: -20)
                }.offset(y: -5)
                
                Divider()
                    .frame(width: 346, height: 8, alignment: .center)
                    .background(Color("Green"))
                    .padding()
                    .offset(y: -30)
                
                
                    
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("Green"))
                        .shadow(color: Color("DarkGrey").opacity(0.7), radius: 20)
                        .offset(y: -55)
                    VStack {
                        Text("Motivations Collection")
                            .font(.system(size: 23))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("Orange"))
                            .padding()
                            .offset(y: -50)
                        QuotesAPI()
                            .offset(y: -55)
                    }
                }
                .offset(y: 30)
                .frame(width: 346, height: 420, alignment: .center)
                Spacer()
            }
        }
    }
}

struct PointsView_Previews: PreviewProvider {
    static var previews: some View {
        PointsView()
    }
}
