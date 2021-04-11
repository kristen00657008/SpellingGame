//
//  CircleInfo.swift
//  SpellingGame
//
//  Created by Chase on 2021/3/29.
//

import Foundation
import SwiftUI

struct Circle_Info:Codable {
    var start_location: CGRect = CGRect.zero
    var offset: CGSize = CGSize.zero
    var new_location: CGRect = CGRect.zero
    var current_location: CGRect = CGRect.zero
}

struct Answer_Circle:Codable {
    var start_location: CGRect = CGRect.zero
    var offset: CGSize = CGSize.zero
    var answer_char: String = ""
    var correct_position: Int = 0
}
