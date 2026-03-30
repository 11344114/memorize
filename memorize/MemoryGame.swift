//
//  MemoryGame.swift
//  memorize
//
//  Created by mis11344114 on 2026/3/30.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]
    
    init(numberOfPairsOfCards: Int,
         createCardContent: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfPairsOfCards {
            var cardContent: CardContent = createCardContent(index)
            cards.append(Card(content: cardContent))
            cards.append(Card(content: cardContent))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
