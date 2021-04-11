//
//  QuestionsData.swift
//  SpellingGame
//
//  Created by Chase on 2021/3/28.
//

import Foundation

struct Question:Codable {
    var id = UUID()
    var word: [String]
    var num: Int
    var full_name: String
    var alphabets: [String]
}

let questions = [Question(word: ["Tayvan"], num: 1, full_name: "Tayvan", alphabets: ["T", "a", "y", "v", "a", "n"]),//台灣
                 Question(word: ["Japonya"], num: 1, full_name: "Japonya", alphabets: ["J", "a", "p", "o", "n", "y", "a"]),//日本
                 Question(word: ["Kore"], num: 1, full_name: "Kore", alphabets: ["K", "o", "r", "e"]),//韓國
                 Question(word: ["Çin"], num: 1, full_name: "Çin", alphabets: ["Ç", "i", "n"]),//中國
                 Question(word: ["Vietnam"], num: 1, full_name: "Vietnam", alphabets: ["V", "i", "e", "t", "n", "a", "m"]),//越南
                 Question(word: ["Tayland"], num: 1, full_name: "Tayland", alphabets: ["T", "a", "y", "l", "a", "n", "d"]),//泰國
                 Question(word: ["ispanya"], num: 1, full_name: "ispanya", alphabets: ["i", "s", "p", "a", "n", "y", "a"]),//西班牙
                 Question(word: ["Hollanda"], num: 1, full_name: "Hollanda", alphabets: ["Ｈ", "p", "l", "l", "a", "n", "d", "a"]),//荷蘭
                 Question(word: ["Almanya"], num: 1, full_name: "Almanya", alphabets: ["A", "l", "m", "a", "n", "y", "a"]),//德國
                 Question(word: ["Türkiye"], num: 1, full_name: "Türkiye", alphabets: ["T", "ü", "r", "k", "i", "y", "e"]),//土耳其
                 Question(word: ["Polonya"], num: 1, full_name: "Polonya", alphabets: ["P", "o", "l", "o", "n", "y", "a"]),//波蘭
                 Question(word: ["Portekiz"], num: 1, full_name: "Portekiz", alphabets: ["P", "o", "r", "t", "e", "k", "i", "z"]),//葡萄牙
                 Question(word: ["Şili"], num: 1, full_name: "Şili", alphabets: ["Ş", "i", "l", "i"]),//智利
                 Question(word: ["Arjantin"], num: 1, full_name: "Arjantin", alphabets: ["A", "r", "j", "a", "n", "t", "i", "n"]),//阿根廷
                 Question(word: ["Meksika"], num: 1, full_name: "Meksika", alphabets: ["M", "e", "k", "s", "i", "k", "a"]),//墨西哥
                 Question(word: ["Rusya"], num: 1, full_name: "Rusya", alphabets: ["Ｒ", "u", "s", "y", "a"]),//俄羅斯
                 Question(word: ["Brezilya"], num: 1, full_name: "Brezilya", alphabets: ["Ｂ", "r", "e", "z", "i", "l", "y", "a"]),//巴西
                 Question(word: ["İtalya"], num: 1, full_name: "İtalya", alphabets: ["İ", "t", "a", "l", "y", "a"]),//義大利
                 Question(word: ["Norveç"], num: 1, full_name: "Norveç", alphabets: ["N", "o", "r", "v", "e", "ç"]),//挪威
                 Question(word: ["İsviçre"], num: 1, full_name: "İsviçre", alphabets: ["İ", "s", "v", "i", "ç", "r", "e"]),// 瑞士
                 Question(word: ["İsveç"], num: 1, full_name: "İsveç", alphabets: ["İ", "s", "v", "e", "ç"]),//瑞典
                 Question(word: ["Malezya"], num: 1, full_name: "Malezya", alphabets: ["M", "a", "l", "e", "z", "y", "a"]),//馬來西亞
                 Question(word: ["Kanada"], num: 1, full_name: "Kanada", alphabets: ["K", "a", "n", "a", "d", "a"]),//加拿大
                 Question(word: ["Fransa"], num: 1, full_name: "Fransa", alphabets: ["F", "r", "a", "n", "s", "a"])]//法國
