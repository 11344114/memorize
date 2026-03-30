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
    
    @State var emojiCount = 20
    
    var body: some View {
        VStack {
            cardList
            Spacer()
            actionButtons
        }
        .padding()
        .foregroundStyle(.orange)
    }

    var cardList: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
                ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                    CardView(content: emoji)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                }
            }
        }
    }
    
    var actionButtons: some View {
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
            
            Group {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(Font.system(size: 300))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(isFaceUp ? 1 : 0)
            
            shape.opacity(isFaceUp ? 0 : 1)
            
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
