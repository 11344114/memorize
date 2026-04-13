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
    // var emojis = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁","🐮","🐷","🐸","🐵","🫎","🐲","🐥","🐙","🪼","🦭","🦧","🦚","🦦","🦥"]
    
    // @State var emojiCount = 20
    
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            cardList
                .animation(.default, value: viewModel.cards)
            Spacer()
            Button("Shuffle") {
                viewModel.shuffle()
            }
            .font(.largeTitle)
            // actionButtons
        }
        .padding()
        .foregroundStyle(.orange)
    }

    var cardList: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }
}

struct CardView: View {
//    @State var isFaceUp: Bool = true
//    var content: String
    
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            // var shape: RoundedRectangle = RoundedRectangle(cornerRadius: 20)
            let shape = RoundedRectangle(cornerRadius: 20)
            // var shape = Circle();
            
            Group {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(Font.system(size: 300))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            shape.opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity(card.isMatched && !card.isFaceUp ? 0 : 1)
        
        // .onTapGesture(perform: {
        //     isFaceUp = !isFaceUp
        // })
    }
}

#Preview {
    ContentView(viewModel: EmojiMemoryGame())
    
}
