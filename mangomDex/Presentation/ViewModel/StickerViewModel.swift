//
//  StickerViewModel.swift
//  mangomDex
//
//  Created by 엄승주 on 3/11/24.
//

import Foundation
import UIKit
import CoreData

class StickerViewModel{
    
    let defaults = UserDefaults.standard
    var review = false
    var onboarding = false
    
    private(set) var stickers: [Sticker] = []
    
    init() {
        for i in 1...73{
            stickers.append(Sticker(id: i))
        }
        
        let first = defaults.object(forKey: "first")
        
        if first == nil {
            onboarding = true
            defaults.set(1, forKey: "first")
        }else{
            defaults.set(first as! Int + 1, forKey: "first")
            if(first as! Int > 3){
                review = true
            }
        }
    }
    
    // function to set initial number
    func setStoredStickerNumber(coreData: [StickerNumbers]){
        for i in coreData{
            let index = i.id - 1
            stickers[Int(index)].number = Int(i.number)
        }
    }
    
    // functions to reest to 0 all sticker number
    func resetNumberToZero(){
        for i in stickers{
            i.number = 0
        }
    }
    
    // function that filter sticker
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
        
        if numStyle == nil {
            defaults.set(true, forKey: "numStyle")
            num = true
        }
        else{
            if let temp = numStyle, temp as! Bool == true{
                num = true
            }
        }
        
        return (fade, num)
    }
    
    func changeId(id: Int) -> String{
        if id < 10{
            return "0\(id)"
        }
        else{
            return "\(id)"
        }
    }
    
    
    func openIink(url:String, type: LinkType){
        
        if let link = URL(string: url) {
            UIApplication.shared.open(link, options: [:], completionHandler: nil)
        } else {
            if type == .insta{
                let instagramWebURL = URL(string: "https://apps.apple.com/kr/app/instagram/id389801252")!
                UIApplication.shared.open(instagramWebURL, options: [:], completionHandler: nil)
            }
        }
    }
    
}
