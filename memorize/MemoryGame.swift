//
//  MemoryGame.swift
//  memorize
//
//  Created by mis11344114 on 2026/3/30.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    var score: Int = 0 // 新增：記住得分 (Model 的一部分)
    
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
    
    var lastFaceUpIndex: Int?
    
    mutating func choose(_ card: Card) {
        // 新增防呆：確保選中的卡片不是已經翻開的，也不是已經配對成功的，避免重複計分或自己跟自己配對
        if let chosenIndex = index(of: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            
            if let lastIndex = lastFaceUpIndex {
                if cards[lastIndex].content == cards[chosenIndex].content {
                    cards[lastIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score += 2 // 新增：match 時 +2 分
                } else {
                    // 新增：翻開第二張卻沒有 match 時，判斷兩張牌是否先前已經翻開過
                    if cards[lastIndex].hasBeenSeen {
                        score -= 1
                    }
                    if cards[chosenIndex].hasBeenSeen {
                        score -= 1
                    }
                }
                
                // 新增：這兩張牌都已經參與過翻牌比較，將它們標記為已翻開過
                cards[lastIndex].hasBeenSeen = true
                cards[chosenIndex].hasBeenSeen = true
                
                lastFaceUpIndex = nil
            } else {
                for i in 0..<cards.count {
                    cards[i].isFaceUp = false
                }
                lastFaceUpIndex = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("cards: \(cards), score: \(score)")
    }
    
    func index(of card: Card) -> Int? {
        for i in 0..<cards.count {
            if cards[i].id == card.id {
                return i
            }
        }
        return nil
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print("shuffle cards: \(cards)")
    }
    
    struct Card: Equatable, Identifiable {
        static func ==(lhs: MemoryGame<CardContent>.Card, rhs:MemoryGame<CardContent>.Card) -> Bool {
            // 新增：比較時加上 hasBeenSeen
            lhs.content == rhs.content && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.id == rhs.id && lhs.hasBeenSeen == rhs.hasBeenSeen
        }
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false // 新增：記住自己有沒有被翻開過
        var content: CardContent
        
        var id: String
    }
}
