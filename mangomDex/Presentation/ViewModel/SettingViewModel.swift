//
//  SettingViewModel.swift
//  mangomDex
//
//  Created by 엄승주 on 3/10/24.
//

import Foundation

class SettingViewModel{
    let defaults = UserDefaults.standard
    let settingDataModel = SettingData()
    
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
    
    //change fade setting
    func fadeSwitchValueChanged(isOn: Bool){
        if isOn {
            defaults.set(true, forKey: "fadeStyle")
        } else {
            defaults.set(false, forKey: "fadeStyle")
        }
    }
    
    //change num setting
    func numSwitchValueChanged(isOn: Bool){
        if isOn {
            defaults.set(true, forKey: "numStyle")
        } else {
            defaults.set(false, forKey: "numStyle")
        }
    }
    
    // reload Sticker Grid
    func triggerReload() {
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReloadGridDataNotification"), object: nil)
     }
    
    //reset StickerData and reset CoreData
    func resetStickerData(){
        settingDataModel.resetStickerNum()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ResetStickerNumberData"), object: nil)
    }
}
