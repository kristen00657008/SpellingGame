//
//  SwiftUIView.swift
//  SpellingGame
//
//  Created by Chase on 2021/4/9.
//

import SwiftUI

struct SwiftUIView: View {
    fileprivate func extractedFunc() -> VStack<Text> {
        return VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
    
    var body: some View {
        extractedFunc()
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
