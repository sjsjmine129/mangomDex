//
//  SettingViewModel.swift
//  mangomDex
//
//  Created by 엄승주 on 3/10/24.
//

import Foundation
import UIKit

class SettingViewModel{
    let defaults = UserDefaults.standard
    
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
    
    // open magbear instagram
    func openInstagram(){
        let instagramURL = URL(string: "instagram://user?username=yurang_official")!
        
        if UIApplication.shared.canOpenURL(instagramURL) {
            UIApplication.shared.open(instagramURL, options: [:], completionHandler: nil)
        } else {
            let instagramWebURL = URL(string: "https://apps.apple.com/kr/app/instagram/id389801252")!
            UIApplication.shared.open(instagramWebURL, options: [:], completionHandler: nil)
        }
    }
    
    // open kakao inquire link
    func openKakaoInquire(){
        let instagramWebURL = URL(string: "https://open.kakao.com/o/s9QZvhfg")!
        UIApplication.shared.open(instagramWebURL, options: [:], completionHandler: nil)
    }
    
    //change fade setting
    func fadeSwitchValueChanged(sender: UISwitch){
        if sender.isOn {
            defaults.set(true, forKey: "fadeStyle")
        } else {
            defaults.set(false, forKey: "fadeStyle")
        }
    }
    
    //change num setting
    func numSwitchValueChanged(sender: UISwitch){
        if sender.isOn {
            defaults.set(true, forKey: "numStyle")
        } else {
            defaults.set(false, forKey: "numStyle")
        }
    }
}
