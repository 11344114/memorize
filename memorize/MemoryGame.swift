//
//  MemoryGame.swift
//  memorize
//
//  Created by mis11344114 on 2026/3/30.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    var score: Int = 0 // 記住得分 (Model 的一部分)
    
    init(numberOfPairsOfCards: Int,
         createCardContent: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfPairsOfCards {
            let cardContent: CardContent = createCardContent(index)
            cards.append(Card(content: cardContent, id: "\(index)a"))
            cards.append(Card(content: cardContent, id: "\(index)b"))
        }
        shuffle()
    }
    
    var lastFaceUpIndex: Int? {
        get { cards.indices.filter ({ cards[$0].isFaceUp }) .oneAndOnly }
            // var faceupIndices = [Int]()
            // for i in cards.indices {
            //     if cards[i].isFaceUp {
            //         faceupIndices.append(i)
            //     }
            // }
            
            // if faceupIndices.count == 1 {
            //     return faceupIndices[0]
            // }
            // else {
            //     return nil
            // }
        set { cards.indices.forEach ({ cards[$0].isFaceUp = $0 == newValue }) }
            
            // for i in cards.indices {
                // cards[i].isFaceUp = i == newValue
                // if i == newValue {
                //     cards[i].isFaceUp = true
                // } else {
                //     cards[i].isFaceUp = false
                // }
        }
    
    mutating func choose(_ card: Card) {
        // 新增防呆：確保選中的卡片不是已經翻開的，也不是已經配對成功的，避免重複計分或自己跟自己配對
        if let chosenIndex = cards.indices.firstIndex(where: {cards[$0].id == card.id }) {
            
            if cards [chosenIndex].isFaceUp || cards[chosenIndex].isMatched {
                return
            }
            
            if let lastIndex = lastFaceUpIndex {
                if cards[lastIndex].content == cards[chosenIndex].content {
                    cards[lastIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score += 2
                } else {
                    if cards[lastIndex].hasBeenSeen {
                        score -= 1
                    }
                    if cards[chosenIndex].hasBeenSeen {
                        score -= 1
                    }
                }
                
                cards[lastIndex].hasBeenSeen = true
                cards[chosenIndex].hasBeenSeen = true
                
                // lastFaceUpIndex = nil
                cards[chosenIndex].isFaceUp = true
                
            } else {

                lastFaceUpIndex = chosenIndex
            }
            
        }
        print("cards: \(cards), score: \(score)")
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print("shuffle cards: \(cards)")
    }
    
    struct Card: Equatable, Identifiable {
        static func ==(lhs: MemoryGame<CardContent>.Card, rhs:MemoryGame<CardContent>.Card) -> Bool {
            lhs.content == rhs.content && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.id == rhs.id && lhs.hasBeenSeen == rhs.hasBeenSeen
        }
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false
        var content: CardContent
        
        var id: String
    }
}

extension Array {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
