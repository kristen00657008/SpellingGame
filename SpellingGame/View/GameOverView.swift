//
//  GameOverView.swift
//  SpellingGame
//
//  Created by Chase on 2021/4/4.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var gameSettings: GameSettings
    @EnvironmentObject var storesData: RecordsData
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.orange, lineWidth: 5)
                .background(Color.init(red: 90/255, green: 90/255, blue: 100/255).frame(width: 500, height: 390))
                .cornerRadius(20)
                .frame(width: gameSettings.geometry_size_width * 0.55, height: gameSettings.geometry_size_height * 0.8)
                .overlay(
                    VStack{
                        Text("本局\(gameSettings.player_name)共花費").font(Font.system(size: 45))
                            .foregroundColor(.yellow)
                        HStack{
                            Text("\(Int(gameSettings.time_min) ?? 0)")
                                .font(Font.system(size: 45))
                            Text("分").font(Font.system(size: 25)).offset(y: 10)
                            Text("\(Int(gameSettings.time_sec) ?? 0).\(Int(gameSettings.time_millisec) ?? 0)").font(Font.system(size: 45))
                            Text("秒").font(Font.system(size: 25)).offset(y: 10)
                        }.foregroundColor(.yellow)
                        HStack{
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
                                    Text("再玩一次").foregroundColor(.yellow)
                                }
                                
                            }).padding(30)
                            
                            Button(action: {
                                appSettings.rankViewBtn()
                            }, label: {
                                VStack{
                                    Image("trophy")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                    Text("排行榜").foregroundColor(.yellow)
                                }
                                
                            }).padding(30)
                        }
                    })
            
        }
        .onAppear{
            storeData()
        }
        
        
        
        
    }
    
   
    
    func restartBtn() {
        appSettings.clickPlayer.playFromStart()
        appSettings.isGameOverView = false
        appSettings.isGameView = true
        gameSettings.restart()
        gameSettings.timer_start()
    }
    
    func storeData() {
        var index = 0
        for i in storesData.records {
            if i.name == gameSettings.player_name {
                let time = gameSettings.time_min + ":" + gameSettings.time_sec + ":" + gameSettings.time_millisec
                let time_num = gameSettings.secondsElapsed
                if time_num < i.time_num {
                    storesData.records.remove(at: index)
                    storesData.records.append(Record(name: gameSettings.player_name, time: time, time_num: time_num))
                    storesData.records.sort {
                        $0.time_num < $1.time_num
                    }
                }
                return
            }
            index += 1
        }
        let time = gameSettings.time_min + ":" + gameSettings.time_sec + ":" + gameSettings.time_millisec
        let time_num = gameSettings.secondsElapsed
        storesData.records.append(Record(name: gameSettings.player_name, time: time, time_num: time_num))
        storesData.records.sort {
            $0.time_num < $1.time_num
        }
    }
    
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
    }
}
