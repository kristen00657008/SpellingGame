//
//  SpellingGameApp.swift
//  SpellingGame
//
//  Created by Chase on 2021/3/28.
//

import SwiftUI
import UIKit
import AVFoundation


@main
struct SpellingGameApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ViewController()
        }
    }
}

extension AVPlayer {
    
    static var bgQueuePlayer = AVQueuePlayer()

    static var bgPlayerLooper: AVPlayerLooper!
    
    static func setupBgMusic() {
        guard let Url = Bundle.main.url(forResource: "background_music", withExtension: "mp3") else{fatalError("Failed to fin sound file.")}
        let item = AVPlayerItem(url: Url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
    }
    
    static let correctPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "correct_music", withExtension: "mp3") else{fatalError("Failed to fin sound file.")}
        return AVPlayer(url: url)
    }()
    
    static let errorPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "error_music", withExtension: "mp3") else{fatalError("Failed to fin sound file.")}
        return AVPlayer(url: url)
    }()
    
    static let clickPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "click_sound", withExtension: "mp3") else{fatalError("Failed to fin sound file.")}
        return AVPlayer(url: url)
    }()
    
    func playFromStart() {
        seek(to: .zero)
        play()
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    @AppStorage("bg_volume") var bg_volume = 1.0
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        AVPlayer.setupBgMusic()
        AVPlayer.bgQueuePlayer.volume = Float(bg_volume)
        AVPlayer.bgQueuePlayer.play()
        
        
        return true
    }
}
