//
//  StickerViewModel.swift
//  mangomDex
//
//  Created by 엄승주 on 3/11/24.
//

import Foundation

class StickerViewModel{
    
    let defaults = UserDefaults.standard
    
    private(set) var stickers: [Sticker] = []
    
    init() {
        for i in 1...73{
            stickers.append(Sticker(id: i))
        }
    }
    
    // function taht filter sticker
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
    
    // function check settings
    func checkSetting() -> (fadeMode: Bool, numMode: Bool){
        let fadeStyle = defaults.object(forKey: "fadeStyle")
        var fade = false
        let numStyle = defaults.object(forKey: "numStyle")
        var num = false
        
        if fadeStyle == nil {
            defaults.set(true, forKey: "fadeStyle")
            fade = true
        }
        else{
            if let temp = fadeStyle, temp as! Bool == true{
                fade = true
            }
        }
        
        if let temp = numStyle, temp as! Bool == true{
            num = true
        }
        
        return (fade, num)
    }
    
}
