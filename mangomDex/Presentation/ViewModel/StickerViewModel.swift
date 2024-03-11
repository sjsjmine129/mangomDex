//
//  StickerViewModel.swift
//  mangomDex
//
//  Created by 엄승주 on 3/11/24.
//

import Foundation

class StickerViewModel{
    
    private(set) var stickers: [Sticker] = []
    
    init() {
        for i in 1...73{
            stickers.append(Sticker(id: i))
        }
        
    }
    
}
