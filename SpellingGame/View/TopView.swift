//
//  TopView.swift
//  SpellingGame
//
//  Created by Chase on 2021/3/28.
//

import SwiftUI
import AVFoundation

struct TopView: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var gameSettings: GameSettings
    
    var body: some View {
        HStack{
            Button(action: {
                pauseBtn()
            }){
                Image("pause")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            Spacer()
            Text("\(gameSettings.time_min):\(gameSettings.time_sec):\(gameSettings.time_millisec)")
                .font(Font.system(size: 30))
                .onTapGesture {
                    gameSettings.secondsElapsed -= 1
                }
            Spacer()
        }
    }
    
    func pauseBtn() {
        gameSettings.timer_pause()
        appSettings.isGameView = false
        appSettings.isPauseView = true
        appSettings.clickPlayer.playFromStart()
    }
    
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
