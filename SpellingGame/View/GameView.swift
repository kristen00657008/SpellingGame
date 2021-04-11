//
//  GameView.swift
//  SpellingGame
//
//  Created by Chase on 2021/3/28.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var gameSettings: GameSettings
    var body: some View {
        VStack{
            TopView().environmentObject(appSettings).environmentObject(gameSettings)
            Spacer()
            MidView().environmentObject(appSettings).environmentObject(gameSettings)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            jumpGame()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            //returnGame()
        }}
    func jumpGame() {
        gameSettings.timer_pause()
        appSettings.isGameView = false
        appSettings.isPauseView = true
    }
    
    func returnGame() {
        appSettings.isGameView = false
        appSettings.isPauseView = true
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
