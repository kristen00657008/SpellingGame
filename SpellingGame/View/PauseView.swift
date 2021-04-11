//
//  PauseView.swift
//  SpellingGame
//
//  Created by Chase on 2021/3/29.
//

import SwiftUI
import AVFoundation

struct PauseView: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var gameSettings: GameSettings
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.orange, lineWidth: 5)
            .background(Color.init(red: 90/255, green: 90/255, blue: 100/255).frame(width: 500, height: 390))
            .cornerRadius(20)
            .frame(width: gameSettings.geometry_size_width * 0.5, height: gameSettings.geometry_size_height * 0.3)
            .overlay( HStack{
                Button(action: {
                    appSettings.homepageBtn()
                }, label: {
                    VStack{
                        Image("house")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("首頁").foregroundColor(.yellow)
                    }
                }).padding(30)
                
                Button(action: {
                    restartBtn()
                }, label: {
                    VStack{
                        Image("replay1")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("重新一局").foregroundColor(.yellow)
                    }
                    
                }).padding(30)
                
                Button(action: {
                    keepBtn()
                }){
                    VStack{
                        Image("play")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("繼續").foregroundColor(.yellow)
                    }
                }.padding(30)
            })
       
    }
    
    func keepBtn() {
        appSettings.clickPlayer.playFromStart()
        appSettings.isGameView = true
        appSettings.isPauseView = false
        gameSettings.timer_restart()
    }
    
    func restartBtn() {
        appSettings.clickPlayer.playFromStart()
        appSettings.isGameOverView = false
        appSettings.isGameView = true
        gameSettings.restart()
        gameSettings.timer_start()
    }
}

struct PauseView_Previews: PreviewProvider {
    static var previews: some View {
        PauseView()
    }
}
