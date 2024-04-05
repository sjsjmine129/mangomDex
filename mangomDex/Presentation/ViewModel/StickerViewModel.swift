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
    //    var review = false
    var onboarding = false
    let coreData = CoreData_mang()
    
    private(set) var stickers: [Sticker] = []
    var filteredStickers: [Sticker] = []
    
    var dropdownImage: Observable<String> = Observable("chevron.down")
    var filterMode: Observable<String> = Observable("전체 보기")
    var numberString: Observable<String> = Observable("0/73")
    
    
    init() {
        let numdata = coreData.getStickerNumber()
        
        for i in numdata{
            let num =  Int(i.number)
            let id = Int(i.id)
            
            stickers.append(Sticker(id: id, number: num))
        }
        let first = defaults.object(forKey: "first")
        
        if first == nil {
            onboarding = true
            defaults.set(1, forKey: "first")
        }else{
            defaults.set(first as! Int + 1, forKey: "first")
            //            if(first as! Int > 3){
            //                review = true
            //            }
        }
        
        filteredStickers = Array(stickers)
        setNumberString()
    }
    
    
    // functions to reest to 0 all sticker number
    func resetNumberToZero(){
        for i in stickers{
            i.number = 0
        }
    }
    
    // function that filter sticker
    func filterSticker(condition:StickerFilter){
        var retStickers: [Sticker] = []
        
        switch condition{
        case .all :
            retStickers = Array(stickers)
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
        
        filteredStickers = retStickers
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
    
    //change id to show data
    func changeId(id: Int) -> String{
        if id < 10{
            return "0\(id)"
        }
        else{
            return "\(id)"
        }
    }
    
    //function to open link of inst or kakao
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
    
    //function make number of sticker
    func setNumberString(){
        var totalNum = Sticker.stickeTotalNum
        var collectNum = 0
        
        let condition = StickerFilter(rawValue: self.filterMode.value!)
        
        switch condition{
        case .all:
            collectNum = countVollected()
        case .collected:
            collectNum = filteredStickers.count
        case .noncollected:
            collectNum = Sticker.stickeTotalNum - filteredStickers.count
        case .season1:
            totalNum = 20
            collectNum = countVollected()
        case .season2:
            totalNum = 53
            collectNum = countVollected()
        default:
            collectNum = 0
        }
        
        numberString.value = "\(collectNum)/\(totalNum)"
    }
    
    // count stikcer collected Num
    func countVollected()->Int{
        var ret = 0
        for i in filteredStickers{
            if i.number != 0{
                ret += 1
            }
        }
        return ret
    }
    
    
    // set dropDownImage
    func setDropDownImage(imgName: String){
        dropdownImage.value = imgName
    }
    
    // when choose filter
    func changeFilter(filtertype: String){
        dropdownImage.value = "chevron.down"
        if let filter = StickerFilter(rawValue: filtertype) {
            filterSticker(condition: filter)
            filterMode.value = filtertype
            setNumberString()
        }
    }
    
    // set grid cell data
    func setGridCellUIData(cell: StickerCollectionViewCell, sticker: Sticker, index: Int, colunms: Int){
        cell.btnSticker.tag = index
        cell.btnSticker.setImage(sticker.image, for: .normal)
        
        let setting = checkSetting()
        
        if setting.numMode {
            var fontSize = 15
            switch colunms{
            case 2:
                fontSize = 30
            case 3:
                fontSize = 20
            case 4:
                fontSize = 15
            case 5:
                fontSize = 12
            case 6:
                fontSize = 10
            case 7:
                fontSize = 8
            case 8:
                fontSize = 8
            case 9:
                fontSize = 6
            default:
                fontSize = 15
            }
            
            cell.lblCollectNum.font = UIFont(name: "HUDdiu150", size: CGFloat(fontSize))
            cell.lblCollectNum.text = "\(sticker.number)"
            cell.lblCollectNum.isHidden = false
        }else{
            cell.lblCollectNum.isHidden = true
        }
        
        if sticker.number == 0 && setting.fadeMode {
            cell.btnSticker.alpha = 0.5
        }else{
            cell.btnSticker.alpha = 0.9
        }
    }
    
    
    // add one sticker
    func addStickerNum(index: Int, cell: StickerCollectionViewCell){
        
        let newNum = filteredStickers[index].number + 1
        if newNum >= 100{
            return
        }
        
        cell.btnSticker.alpha = 0.9
        cell.lblCollectNum.text = "\(newNum)"
        
        stickers[filteredStickers[index].id - 1].number = newNum
        
        coreData.changeStickerNum(id: filteredStickers[index].id, newNum: newNum)
        
        if newNum == 1{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeCollectionNum"), object: nil)
        }
    }
    
    // set Zero the sticker num
    func zeroStickerNum(index: Int, cell: StickerCollectionViewCell){
        if filteredStickers[index].number == 0{
            return
        }
        
        let newNum = 0
        let mode = checkSetting()
        if  mode.fadeMode {
            cell.btnSticker.alpha = 0.5
        }
        
        cell.lblCollectNum.text = "\(newNum)"
        
        stickers[filteredStickers[index].id - 1].number = newNum
        
        coreData.changeStickerNum(id: filteredStickers[index].id, newNum: newNum)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeCollectionNum"), object: nil)
    }
    
}
