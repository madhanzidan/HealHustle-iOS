//
//  MainView.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 23/07/22.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("White"))
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Hustle", systemImage: "clock.fill")
                }
                .environmentObject(TaskStore())
            PointsView()
                .tabItem {
                    Label("Points", systemImage: "flame.fill")
                }
        }
        .accentColor(Color("Orange"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
