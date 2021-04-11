//
//  ContentView.swift
//  SpellingGame
//
//  Created by Chase on 2021/3/28.
//

import SwiftUI
import AVFoundation

struct ViewController: View {
    @StateObject var appSettings = AppSettings()
    @StateObject var gameSettings = GameSettings()
    @StateObject var storesData = RecordsData()
    @State var looper: AVPlayerLooper?
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack{
                if appSettings.isSettingView {
                    Image("earth")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    SettingView().environmentObject(appSettings).environmentObject(gameSettings)
                }
                else if appSettings.isRankView {
                    RankView().environmentObject(appSettings).environmentObject(gameSettings).environmentObject(storesData)
                }
                else if appSettings.isHomePageView {
                    Image("earth")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    HomePageView().environmentObject(appSettings).environmentObject(gameSettings).environmentObject(storesData)
                }
                else if appSettings.isGameView {
                    Image("map")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    GameView().environmentObject(appSettings).environmentObject(gameSettings)
                }
                else if appSettings.isPauseView {
                    Image("map")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    PauseView().environmentObject(appSettings).environmentObject(gameSettings)
                }
                
                else if appSettings.isGameOverView {
                    Image("overbackground")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    GameOverView().environmentObject(appSettings).environmentObject(gameSettings).environmentObject(storesData)
                }
               
            }.onAppear{
                gameSettings.geometry_size_width = geometry.size.width
                gameSettings.geometry_size_height = geometry.size.height
            }
            
        })
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
    }
}
