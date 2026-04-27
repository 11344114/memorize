//
//  ContentView.swift
//  memorize
//
//  Created by mis11344114 on 2026/3/16.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            // 頂部資訊區塊
            HStack {
                // 新增：在任意區塊新增顯示目前選取的 Theme name
                Text(viewModel.themeName)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Spacer()
                
                Text("目前得分: \(viewModel.score)")
                    .font(.system(size: 30, weight: .bold)) // 稍微縮小以配合主題標題
                    .foregroundStyle(.red)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            cardList
                .animation(.default, value: viewModel.cards)
            
            Spacer()
            
            // 底部按鈕區塊
            HStack {
                Button(action: {
                    viewModel.shuffle()
                }) {
                    VStack {
                        Text("Shuffle")
                        .font(.largeTitle)
                    }
                }
                .foregroundStyle(.red) // 修改：固定為紅色，不隨主題改變  
                .fontWeight(.bold)

                Spacer()
                
                // 新增：新遊戲按鈕 (包含文字與 SF Symbol，上下排列，不同大小)
                Button(action: {
                    viewModel.newGame()
                }) {
                    VStack {
                        Image(systemName: "play.circle.fill") // SF Symbol
                            .font(.system(size: 40))         // 圖示較大
                        Text("新遊戲")                     // 文字
                            .font(.headline)                 // 文字較小
                    }
                }
                .foregroundStyle(.red) // 修改：固定為紅色，不隨主題改變
            }
            .padding(.horizontal, 40)
            .padding(.top, 10)
        }
        .padding()
        // 新增：卡片背面的顏色根據 Theme 設定的 color (這會套用到裡面所有預設的前景色，包含卡片背面)
        .foregroundStyle(viewModel.themeColor)
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
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
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
    }
}

#Preview {
    ContentView(viewModel: EmojiMemoryGame())
}
