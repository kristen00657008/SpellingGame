//
//  GameSettings.swift
//  SpellingGame
//
//  Created by Chase on 2021/3/28.
//

import Foundation
import SwiftUI

class GameSettings: ObservableObject {
    @Published var current_question_num: Int = 0
    @Published var current_questions: [Question] = []
    @Published var current_question: Question = Question(word: [], num: 0, full_name: "", alphabets: [])
    @Published var current_question_shuffled: Question = Question(word: [], num: 0, full_name: "", alphabets: [])
    @Published var circles: [Circle_Info] = []
    @Published var answer_circles: [Answer_Circle] = []
    @Published var geometry_size_width: CGFloat = 0
    @Published var geometry_size_height: CGFloat = 0
    @Published var answered_size: [CGFloat] = []
    @Published var time_min: String = "00"
    @Published var time_sec: String = "00"
    @Published var time_millisec: String = "0"
    @Published var num: Int = 1
    @Published var time_record: Double = 0
    @Published var frame: CGFloat = 0
    @Published var player_name = ""
    @Published var secondsElapsed = 0.0
    
    private var timer: Timer?
    private var startDate: Date?
    private var frequency = 0.1
    
    
    func timer_start() {
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { timer in
            if let startDate = self.startDate {
                self.secondsElapsed = Double(timer.fireDate.timeIntervalSince1970 - startDate.timeIntervalSince1970)
            }
            
            if Int(self.secondsElapsed) < 60 {
                self.time_min = "0" + String(Int(self.secondsElapsed) / 60)
                
            }else {
                self.time_min = String(Int(self.secondsElapsed) / 60)
            }
            
            if Int(self.secondsElapsed) % 60 < 10 {
                self.time_sec = "0" + String(Int(self.secondsElapsed) % 60)
            }else {
                self.time_sec = String(Int(self.secondsElapsed) % 60)
            }
            
            self.time_millisec = String(Int(self.secondsElapsed * 10) % 10)
        }
    }
    
    func timer_stop() {
        timer?.invalidate()
        timer = nil
    }
    
    func timer_pause() {
        timer?.invalidate()
        timer = nil
        self.time_record = self.secondsElapsed
    }
    
    func timer_restart() {
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { timer in
            if let startDate = self.startDate {
                self.secondsElapsed = Double(timer.fireDate.timeIntervalSince1970 - startDate.timeIntervalSince1970) + self.time_record
            }
            
            if Int(self.secondsElapsed) < 60 {
                self.time_min = "0" + String(Int(self.secondsElapsed) / 60)
                
            }else {
                self.time_min = String(Int(self.secondsElapsed) / 60)
            }
            
            if Int(self.secondsElapsed) % 60 < 10 {
                self.time_sec = "0" + String(Int(self.secondsElapsed) % 60)
            }else {
                self.time_sec = String(Int(self.secondsElapsed) % 60)
            }
            
            self.time_millisec = String(Int(self.secondsElapsed * 10) % 10)
        }
    }
    
    func restart() {
        circles.removeAll()
        answer_circles.removeAll()
        shuffle_questions()
        num = 1
        for i in 0..<current_question.alphabets.count {
            circles.append(Circle_Info(start_location: CGRect.zero, offset: CGSize.zero, new_location: CGRect.zero))
           answer_circles.append(Answer_Circle(start_location: CGRect.zero, offset: CGSize.zero, answer_char: current_question.alphabets[i]))
            
        }
        current_question_shuffled = current_question
        current_question_shuffled.alphabets = current_question.alphabets.shuffled()
        print(current_question.alphabets)
        print(current_question_shuffled.alphabets)
    }
    
    func shuffle_questions() {
        current_questions = questions
        current_questions.shuffle()
        current_question_num = 0
        current_question = current_questions[0]
    }
}
