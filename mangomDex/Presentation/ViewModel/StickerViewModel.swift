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
    
}
