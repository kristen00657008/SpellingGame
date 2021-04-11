//
//  SettingView.swift
//  SpellingGame
//
//  Created by Chase on 2021/4/4.
//

import SwiftUI
import AVFoundation

struct SettingView: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var gameSettings: GameSettings
    @AppStorage("sound_effect_volume") var sound_effect_volume = 1.0
    @AppStorage("bg_volume") var bg_volume = 1.0
    @AppStorage("voice_volume") var voice_volume = 1.0
    
    var body: some View {
        ZStack{
            Button(action: {
                appSettings.isSettingView = false
            }, label: {
                Image("undo")
                    .resizable()
                    .frame(width: 40, height: 40)
            }).position(x: 60, y: 30)
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.orange, lineWidth: 5)
                .background(Color.init(red: 90/255, green: 90/255, blue: 100/255).frame(width: 500, height: 390))
                .cornerRadius(20)
                .frame(width: gameSettings.geometry_size_width * 0.55, height: gameSettings.geometry_size_height * 0.4)
                .overlay(
                    VStack{
                        HStack{
                            Text("背景音樂")
                                .font(Font.system(size: 25))
                            Slider(value: $bg_volume, in: 0...0.8 ){_ in
                                AVPlayer.bgQueuePlayer.volume = Float(bg_volume)
                                }
                        }.frame(width: UIScreen.main.bounds.width * 0.45)
                        HStack{
                            Text("音效")
                                .font(Font.system(size: 25))
                            Slider(value: $sound_effect_volume, in: 0...1 ){_ in
                                appSettings.clickPlayer.volume = Float(sound_effect_volume)
                                appSettings.correctPlayer.volume = Float(sound_effect_volume)
                                appSettings.errorPlayer.volume = Float(sound_effect_volume)
                                }
                        }.frame(width: UIScreen.main.bounds.width * 0.45)
                        HStack{
                            Text("語音")
                                .font(Font.system(size: 25))
                            Slider(value: $voice_volume, in: 0...1 ){_ in
                               
                                }
                        }.frame(width: UIScreen.main.bounds.width * 0.45)
                }.foregroundColor(.white))
            
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
