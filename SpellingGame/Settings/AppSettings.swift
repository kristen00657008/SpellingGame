//
//  AppSettings.swift
//  SpellingGame
//
//  Created by Chase on 2021/3/28.
//

import Foundation
import AVFoundation
import SwiftUI

class AppSettings: ObservableObject {
    @Published var isHomePageView = true
    @Published var isGameView = false
    @Published var isTopView = false
    @Published var isPauseView = false
    @Published var isSettingView = false
    @Published var isGameOverView = false
    @Published var isNamed = false
    @Published var isRankView = false
    
    var correctPlayer: AVPlayer {AVPlayer.correctPlayer}
    var errorPlayer: AVPlayer {AVPlayer.errorPlayer}
    var clickPlayer: AVPlayer {AVPlayer.clickPlayer}
    
    func rankViewBtn() {
        isRankView = true
        clickPlayer.playFromStart()
    }
    
    func homepageBtn() {
        isGameOverView = false
        isHomePageView = true
        isNamed = false
        clickPlayer.playFromStart()
    }
    
}
