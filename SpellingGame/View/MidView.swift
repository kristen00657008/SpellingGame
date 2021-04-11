//
//  MidView.swift
//  SpellingGame
//
//  Created by Chase on 2021/3/28.
//

import SwiftUI
import AVFoundation

struct MidView: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var gameSettings: GameSettings
    @State private var correct_num = 0
    var correctPlayer: AVPlayer {AVPlayer.correctPlayer}
    var errorPlayer: AVPlayer {AVPlayer.errorPlayer}
    var clickPlayer: AVPlayer {AVPlayer.clickPlayer}
    @AppStorage("sound_effect_volume") var sound_effect_volume = 1.0
    @AppStorage("bg_volume") var bg_volume = 1.0
    @AppStorage("voice_volume") var voice_volume = 1.0
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack{
                ForEach(0..<gameSettings.current_question_shuffled.alphabets.count, id: \.self) { (index) in
                    Rectangle()
                        .clipShape(Circle())
                        .overlay(Text(gameSettings.current_question_shuffled.alphabets[index]).font(Font.system(size: 75)).foregroundColor(.white).padding(.bottom, 10).padding(.top, 5))
                        .frame(width: gameSettings.frame, height: gameSettings.frame)
                        .position(x: 0, y: 0)
                        .offset(gameSettings.circles[index].offset)
                        .gesture(DragGesture()
                                    .onChanged({ value in
                                        gameSettings.circles[index].offset.width = gameSettings.circles[index].new_location.origin.x + value.translation.width
                                        gameSettings.circles[index].offset.height = gameSettings.circles[index].new_location.origin.y + value.translation.height
                                        gameSettings.circles[index].current_location = CGRect(x: gameSettings.circles[index].offset.width, y: gameSettings.circles[index].offset.height, width: gameSettings.circles[index].new_location.width, height: gameSettings.circles[index].new_location.height)
                                    })
                                    .onEnded({value in
                                        speak(word: gameSettings.current_question_shuffled.alphabets[index])
                                        gameSettings.circles[index].new_location = CGRect(x:  gameSettings.circles[index].new_location.origin.x + value.translation.width, y: gameSettings.circles[index].new_location.origin.y + value.translation.height, width: gameSettings.circles[index].new_location.width, height: gameSettings.circles[index].new_location.height)
                                        gameSettings.circles[index].current_location = gameSettings.circles[index].new_location
                                        
                                        print(gameSettings.current_question_shuffled.alphabets[index])
                                        true_or_false(index: index)
                                    })
                        )
                        .onTapGesture {
                            gameSettings.circles[index].offset.width = gameSettings.circles[index].start_location.origin.x
                            gameSettings.circles[index].offset.height = gameSettings.circles[index].start_location.origin.y
                            gameSettings.circles[index].new_location = gameSettings.circles[index].start_location
                            speak(word: gameSettings.current_question_shuffled.alphabets[index])
                        }
                }.zIndex(2)
                HStack{
                    Button(action: {
                        speak(word: gameSettings.current_questions[gameSettings.current_question_num].full_name)
                    }){
                        Image("speak")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Spacer()
                    Image("\(gameSettings.current_question.full_name)")
                        .resizable()
                        .frame(width: 300, height: 200)
                        .offset(x: 30)
                    Spacer()
                    VStack{
                        Text("第")
                        Text("\(gameSettings.num)")
                        Text("題")
                    }.font(Font.system(size: 35))
                    /*Button(action: {
                        game_over()
                    }){
                        Text("game over")
                    }*/
                }
                ForEach(0..<gameSettings.current_question.alphabets.count, id: \.self) { (index) in
                    Rectangle()
                        .clipShape(Circle())
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .position(x: 0, y: 0)
                        .offset(gameSettings.answer_circles[index].offset)
                        .shadow(radius: 20)
                        .onTapGesture {
                            print(gameSettings.answer_circles[index].start_location)
                            print(gameSettings.answer_circles[index].offset)
                            print(gameSettings.answer_circles[index].answer_char)
                        }
                }.zIndex(1)
            }
            .onAppear{
                resetLocation()
                speak(word: gameSettings.current_questions[gameSettings.current_question_num].full_name)
            }
        })
    }
    
    func resetLocation() {
        gameSettings.answered_size.removeAll()
        let mid = gameSettings.circles.count / 2
        gameSettings.frame = 80
        for i in 0..<gameSettings.circles.count {
            if i == mid {
                gameSettings.circles[i].offset = CGSize(width: gameSettings.geometry_size_width * 0.5, height: gameSettings.geometry_size_height * 0.1)
                gameSettings.answer_circles[i].offset = CGSize(width: gameSettings.geometry_size_width * 0.5, height: gameSettings.geometry_size_height * 0.8)
            }
            else {
                gameSettings.circles[i].offset = CGSize(width: gameSettings.geometry_size_width * 0.5 + CGFloat((i-mid) * 100), height: gameSettings.geometry_size_height * 0.1)
                gameSettings.answer_circles[i].offset = CGSize(width: gameSettings.geometry_size_width * 0.5 + CGFloat((i-mid) * 100), height: gameSettings.geometry_size_height * 0.8)
            }
            if gameSettings.circles.count % 2 == 0 {
                gameSettings.circles[i].offset.width += gameSettings.frame
                gameSettings.answer_circles[i].offset.width += gameSettings.frame
            }
            gameSettings.circles[i].start_location = CGRect(x: gameSettings.circles[i].offset.width, y: gameSettings.circles[i].offset.height, width: gameSettings.frame, height: gameSettings.frame)
            gameSettings.circles[i].new_location = gameSettings.circles[i].start_location
            gameSettings.circles[i].current_location = gameSettings.circles[i].start_location
            gameSettings.answer_circles[i].start_location = CGRect(x: gameSettings.answer_circles[i].offset.width, y: gameSettings.answer_circles[i].offset.height, width: gameSettings.frame, height: gameSettings.frame)
            gameSettings.answered_size.append(CGFloat.zero)
        }
    }
    
    func speak(word: String) {
        let utterance =  AVSpeechUtterance(string: word)
        utterance.pitchMultiplier = 2
        utterance.rate = 0.1
        utterance.volume = Float(voice_volume)
        utterance.voice = AVSpeechSynthesisVoice(language: "tr-TR")
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func nextBtn() {
        correct_num = 0
        gameSettings.num += 1
        if gameSettings.num > 10 {
            game_over()
            return
        }
        gameSettings.current_question_num += 1
        gameSettings.current_question = gameSettings.current_questions[gameSettings.current_question_num]
        gameSettings.circles.removeAll()
        gameSettings.answer_circles.removeAll()
        gameSettings.frame = 80
        for i in 0..<gameSettings.current_question.alphabets.count {
            gameSettings.circles.append(Circle_Info(start_location: CGRect.zero, offset: CGSize.zero, new_location: CGRect.zero))
            gameSettings.answer_circles.append(Answer_Circle(start_location: CGRect.zero, offset: CGSize.zero, answer_char: gameSettings.current_question.alphabets[i]))
            gameSettings.circles[i].offset = CGSize.zero
            gameSettings.circles[i].new_location = CGRect(x: 0, y: 0, width: gameSettings.circles[i].start_location.width, height: gameSettings.circles[i].start_location.height)
        }
        
        resetLocation()
        print(gameSettings.current_question_num)
        speak(word: gameSettings.current_questions[gameSettings.current_question_num].full_name)
        updateQuestion()
    }
    
    func updateQuestion() {
        gameSettings.current_question_shuffled = gameSettings.current_question
        gameSettings.current_question_shuffled.alphabets = gameSettings.current_question.alphabets.shuffled()
    }
    
    func true_or_false(index: Int) {
        for i in 0..<gameSettings.answer_circles.count {
            if gameSettings.circles[index].current_location.intersects(gameSettings.answer_circles[i].start_location) {
                if gameSettings.circles[index].current_location.intersection(gameSettings.answer_circles[i].start_location).width >= gameSettings.answer_circles[i].start_location.width / 2 && gameSettings.circles[index].current_location.intersection(gameSettings.answer_circles[i].start_location).height >= gameSettings.answer_circles[i].start_location.height / 2 {
                    if gameSettings.current_question_shuffled.alphabets[index] == gameSettings.answer_circles[i].answer_char {
                        print("touch correct position ")
                        correctPlayer.playFromStart()
                        gameSettings.answer_circles[i].correct_position = index
                        withAnimation{
                            gameSettings.circles[index].offset = gameSettings.answer_circles[i].offset
                            gameSettings.circles[index].new_location = gameSettings.answer_circles[i].start_location
                        }
                        correct_num += 1
                        if correct_num == gameSettings.circles.count {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                enlarge()
                                speak(word: gameSettings.current_question.full_name)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                    nextBtn()
                                }
                            }
                        }
                        return
                    }
                }
                errorPlayer.playFromStart()
            }
            
        }
        withAnimation{
            gameSettings.circles[index].offset.width = gameSettings.circles[index].start_location.minX
            gameSettings.circles[index].offset.height = gameSettings.circles[index].start_location.minY
            gameSettings.circles[index].new_location = gameSettings.circles[index].start_location
        }
        return
    }
    
    func game_over() {
        gameSettings.timer_stop()
        appSettings.isGameView = false
        appSettings.isGameOverView = true
    }
    
    func enlarge() {
        let mid = gameSettings.circles.count / 2
        for i in 0..<gameSettings.circles.count {
            withAnimation{
                if i == mid {
                    gameSettings.circles[gameSettings.answer_circles[i].correct_position].offset = CGSize(width: gameSettings.geometry_size_width * 0.5, height: gameSettings.geometry_size_height * 0.5)
                    gameSettings.answer_circles[i].offset = CGSize(width: gameSettings.geometry_size_width * 0.5, height: gameSettings.geometry_size_height * 0.5)
                }
                else {
                    gameSettings.circles[gameSettings.answer_circles[i].correct_position].offset = CGSize(width: gameSettings.geometry_size_width * 0.5 + CGFloat((i-mid) * 100), height: gameSettings.geometry_size_height * 0.5)
                    gameSettings.answer_circles[i].offset = CGSize(width: gameSettings.geometry_size_width * 0.5 + CGFloat((i-mid) * 100), height: gameSettings.geometry_size_height * 0.5)
                }
                if gameSettings.circles.count % 2 == 0 {
                    gameSettings.circles[gameSettings.answer_circles[i].correct_position].offset.width += 50
                    gameSettings.answer_circles[i].offset.width += 50
                }
                gameSettings.circles[gameSettings.answer_circles[i].correct_position].start_location = CGRect(x: gameSettings.circles[i].offset.width, y: gameSettings.circles[i].offset.height, width: 80, height: 80)
                gameSettings.circles[gameSettings.answer_circles[i].correct_position].new_location = gameSettings.circles[i].start_location
                gameSettings.circles[gameSettings.answer_circles[i].correct_position].current_location = gameSettings.circles[i].start_location
                gameSettings.answer_circles[i].start_location = CGRect(x: gameSettings.answer_circles[i].offset.width, y: gameSettings.answer_circles[i].offset.height, width: 80, height: 80)
                gameSettings.frame = 100
            }
        }
    }
}
