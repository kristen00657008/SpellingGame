//
//  HomePageView.swift
//  SpellingGame
//
//  Created by Chase on 2021/3/28.
//

import SwiftUI
import AVFoundation

struct HomePageView: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var gameSettings: GameSettings
    @EnvironmentObject var storesData: RecordsData
    @State private var name_alert = false
    @AppStorage("sound_effect_volume") var sound_effect_volume = 1.0
    @AppStorage("bg_volume") var bg_volume = 1.0
    @AppStorage("voice_volume") var voice_volume = 1.0
    
    var body: some View {
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        appSettings.isSettingView = true
                    }, label: {
                        Image("setting")
                            .resizable()
                            .frame(width: 30, height: 30)
                    })
                }.frame(height: 30)
                Spacer()
                if appSettings.isNamed {
                    HStack{
                        TextField("你的名字", text: $gameSettings.player_name)
                            .padding()
                            .frame(width: gameSettings.geometry_size_width * 0.3)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue, lineWidth: 5)
                                    .background(Color.white)
                                    .cornerRadius(20)
                            )
                            .padding()
                        
                        Button(action: {
                            startBtn()
                        }, label: {
                            Text("確定")
                                .font(Font.system(size: 30))
                                .frame(width: 80, height: 45)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(10)
                        })
                        
                    }.offset(y: -100)
                }
                else {
                    VStack{
                        Button(action: {
                            enterName()
                        }){
                            Text("開始遊戲")
                                .frame(width: 160, height: 60)
                                .font(Font.system(size: 30))
                                .foregroundColor(.white)
                            
                        }
                        .background(Color.gray)
                        .cornerRadius(5.0)
                        .padding(10)
                        
                        Button(action: {
                            appSettings.rankViewBtn()
                        }){
                            Text("排行榜")
                                .frame(width: 160, height: 60)
                                .font(Font.system(size: 30))
                                .foregroundColor(.white)
                            
                        }
                        .background(Color.gray)
                        .cornerRadius(5.0)
                        .padding(10)
                    }.offset(y: -60)
                    
                }
            }
            .alert(isPresented: $name_alert) { () -> Alert in
               return Alert(title: Text("請輸入姓名"))
            }
            
        
    }
    
    func startBtn(){
        appSettings.clickPlayer.playFromStart()
        if gameSettings.player_name == "" {
            self.name_alert = true
        }
        else {
            appSettings.isHomePageView = false
            appSettings.isGameView = true
            gameSettings.restart()
            gameSettings.timer_start()
        }
    }
    
    func enterName() {
        appSettings.clickPlayer.playFromStart()
        appSettings.isNamed = true
    }
    
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
