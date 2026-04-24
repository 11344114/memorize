//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by mis11344114 on 2026/3/30.
//

import Foundation

@Observable
class EmojiMemoryGame {
    private static var emojis = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁","🐮","🐷","🐸","🐵","🫎","🐲","🐥","🐙","🪼","🦭","🦧","🦚","🦦","🦥"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4,
            createCardContent: {index in EmojiMemoryGame.emojis[index]})
    }
    
    private var model: MemoryGame<String> = createMemoryGame()

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // 新增：將分數開放給 View 讀取
    var score: Int {
        model.score
    }
    
    // MARK: - intent
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
