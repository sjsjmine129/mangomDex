//
//  SettingViewModel.swift
//  mangomDex
//
//  Created by 엄승주 on 3/10/24.
//

import Foundation
import UIKit

class SettingViewModel{
    
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
}
