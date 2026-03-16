//
//  ContentView.swift
//  memorize
//
//  Created by mis11344114 on 2026/3/16.
//

import SwiftUI

struct ContentView: View {
//    var name: String = "Ken"
//    var greeting: String {
//        "hi, \(name)"
//    }
    
    var body: some View {
        HStack{
            CardView(isFaceUp: false)
            CardView()
            CardView()
            CardView()
        }
        .padding()
        .foregroundStyle(.orange)
    }
}

struct CardView: View {
    var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                Text("✈️")
            }
            else {
                RoundedRectangle(cornerRadius: 20)
            }
        }
    }
}

#Preview {
    ContentView()

}
