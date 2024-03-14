//
//  StickerViewModel.swift
//  mangomDex
//
//  Created by 엄승주 on 3/11/24.
//

import Foundation

class StickerViewModel{
    
    static var fadeMode = true
    static var numberMode = false
    
    private(set) var stickers: [Sticker] = []
    
    init() {
        for i in 1...73{
            stickers.append(Sticker(id: i))
        }
        
    }
    
    func filteredStickers(condition:StickerFilter)->[Sticker]{
        var retStickers: [Sticker] = []
        
        switch condition{
        case .all :
            return stickers
        case .collected:
            for i in stickers{
                if i.number > 0 {
                    retStickers.append(i)
                }
            }
        case .noncollected:
            for i in stickers{
                if i.number == 0 {
                    retStickers.append(i)
                }
            }
        case .season1:
            retStickers = Array(stickers[0...19])
        case .season2:
            retStickers = Array(stickers[20...72])
        }
        return retStickers
    }
    
}
