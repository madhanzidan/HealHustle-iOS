//
//  BreakTimeView.swift
//  HealHustle
//
//  Created by Zidan Ramadhan on 27/07/22.
//

import SwiftUI
import AVKit

struct BreakTimeView: View {
    
    @AppStorage("PROD_NAME") var prodNameLabel: String = ""
    @State var audioPlayer: AVAudioPlayer!

    var body: some View {
        ZStack {
            Color("Orange")
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("BREAK TIME")
                        .font(.system(size: 48))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("Green"))
                    Text(prodNameLabel)
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                        .foregroundColor(Color("White"))
                }
                Image("RelaxMan")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .center)
                    .padding()
                VStack {
                    Text("Continue After")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Green"))
                    BreakTimer()
                        .offset(y: -8)
                }.offset(y: 10)
                
                NavigationLink {
                    SuccessView()
                } label: {
                    Text("End")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Orange"))
                        .frame(width: 134, height: 55)
                        .background(Color("Green"))
                        .cornerRadius(20)
                        .shadow(color: Color("Shadow"), radius: 5)
                        .offset(y: -25)
                }

            }
            .offset(y: 20)
        }
        .onAppear {
            let sound = Bundle.main.path(forResource: "Liebesleid", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.numberOfLoops = -1
            self.audioPlayer.play()
        }
        .onDisappear {
            self.audioPlayer.stop()
        }
        .navigationBarHidden(true)
        
    }
}

struct BreakTimeView_Previews: PreviewProvider {
    static var previews: some View {
        BreakTimeView()
    }
}
