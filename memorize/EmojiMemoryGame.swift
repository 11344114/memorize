//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by mis11344114 on 2026/3/30.
//

import SwiftUI // 引入 SwiftUI 讓我們可以回傳 Color 給 View 使用

@Observable
class EmojiMemoryGame {
    
    // 新增：同時管理 ThemePool & Theme
    private var themePool: ThemePool<String>
    private var currentTheme: ThemePool<String>.Theme
    private var model: MemoryGame<String>
    
    // 新增：將主題名稱與顏色開放給 View 讀取
    var themeName: String {
        currentTheme.name
    }
    
    var themeColor: Color {
        switch currentTheme.color {
        case "brown": return .brown
        case "green": return .green
        case "yellow": return .yellow
        case "blue": return .blue
        default: return .black
        }
    }

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // 新增：自訂定義 init，決定建構物件的順序
    init() {
        // 1. 先建立 themePool
        let initializedPool = EmojiMemoryGame.createThemePool()
        self.themePool = initializedPool
        
        // 2. 隨機選擇一個 Theme
        let randomTheme = initializedPool.themes.randomElement()!
        self.currentTheme = randomTheme
        
        // 3. 將 theme 帶入 createMemoryGame 建立 MemoryGame
        self.model = EmojiMemoryGame.createMemoryGame(with: randomTheme)
    }
    
    // 新增：建立 ThemePool 並加入最少三組以上不同的 Theme (皆大於等於 6 對)
    private static func createThemePool() -> ThemePool<String> {
        var pool = ThemePool<String>()
        // color 要能代表該主題特色，動物住在森林是咖啡色，交通看紅綠燈是綠色，水果很鮮艷是黃色，運動在晴天是藍色
        pool.addTheme(name: "動物", color: "brown", numberOfPairs: 8, items: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁","🐮","🐷","🐸","🐵"])
        pool.addTheme(name: "交通", color: "green", numberOfPairs: 6, items: ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚐","🛻","🚚"])
        pool.addTheme(name: "水果", color: "yellow", numberOfPairs: 7, items: ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🥭"])
        pool.addTheme(name: "運動", color: "blue", numberOfPairs: 6, items: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🪀","🏓"])
        return pool
    }
    
    // 新增：createMemoryGame 的 numberOfPairs 與 emojis 改從 Theme 取得
    private static func createMemoryGame(with theme: ThemePool<String>.Theme) -> MemoryGame<String> {
        // 新增：被選定的 Theme 需隨機提供 items 內容
        let shuffledItems = theme.items.shuffled()
        
        // 防呆設計：避免 numberOfPairs 大於陣列擁有的 emoji 數量
        let actualPairs = min(theme.numberOfPairs, shuffledItems.count)
        
        return MemoryGame<String>(numberOfPairsOfCards: actualPairs) { index in
            shuffledItems[index]
        }
    }
    
    // MARK: - intent
    
    // 新增：供 View 重新開始一個全新遊戲
    func newGame() {
        // 隨機選擇一個 Theme
        currentTheme = themePool.themes.randomElement()!
        // 建立新遊戲，此時 score 會自動重置為 0，且 Emoji 也會重新抽樣與洗牌
        model = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
