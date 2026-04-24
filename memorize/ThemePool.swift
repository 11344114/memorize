//
//  ThemePool.swift
//  memorize
//
//  Created by mis11344114 on 2026/4/24.
//

import Foundation

// 新增：ThemePool Model，使用 Generic 型別 ItemContent
struct ThemePool<ItemContent> where ItemContent: Equatable {
    
    // 新增：包含 Theme 陣列，並使用 private(set) 進行 Access Control
    private(set) var themes: [Theme] = []
    
    // 新增：加入 Theme 的方法
    mutating func addTheme(name: String, color: String, numberOfPairs: Int, items: [ItemContent]) {
        themes.append(Theme(name: name, color: color, numberOfPairs: numberOfPairs, items: items))
    }
    
    // 新增：建立在 ThemePool 底下的 Nested Model (Theme)
    struct Theme: Equatable {
        var name: String
        var color: String // 使用字串代表顏色，讓 Model 不依賴 SwiftUI
        var numberOfPairs: Int
        var items: [ItemContent] // Generic 陣列
    }
}
