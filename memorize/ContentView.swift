//
//  ContentView.swift
//  memorize
//
//  Created by mis11344114 on 2026/3/16.
//

import SwiftUI

struct ContentView: View {
    
    // var name: String = "Ken"
    // var greeting: String {
    //     "hi, \(name)"
    // }
    
    // var emojis: Array<String> = ["A","B","C","D","E"]
    // var emojis: [String] = ["A","B","C","D","E"]
    var emojis = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    @State var emojiCount = 6
    
    var body: some View {
        VStack {
            HStack {
                ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                    CardView(content: emoji)
                }
            }
            
            HStack {
                // Button(action: {
                //     if emojiCount > 1 {
                //         emojiCount -= 1
                //     }
                //     emojiCount -= 1
                // }, label: {
                //     Text("Remove Card")
                // })
                
                remove
                Spacer()
                add
                
            }
            .font(.largeTitle)
        }
        .padding()
        .foregroundStyle(.orange)
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    
    var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
    
}

struct CardView: View {
    @State var isFaceUp: Bool = true
    var content: String
    var body: some View {
        ZStack {
            // var shape: RoundedRectangle = RoundedRectangle(cornerRadius: 20)
            let shape = RoundedRectangle(cornerRadius: 20)
            // var shape = Circle();
            
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            else {
                shape
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
        
        // .onTapGesture(perform: {
        //     isFaceUp = !isFaceUp
        // })
        
    }
}

#Preview {
    ContentView()
    
}
