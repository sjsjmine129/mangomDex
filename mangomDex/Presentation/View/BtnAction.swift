//
//  BtnAction.swift
//  mangomDex
//
//  Created by 엄승주 on 3/16/24.
//

import Foundation
import UIKit

class BtnAction{
    static func btnActionAll(button: UIButton) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.1
        pulse.fromValue = 1.0
        pulse.toValue = 1.1
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.1
        flash.fromValue = 0.8
        flash.toValue = 0.5
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        
        button.layer.add(flash, forKey: nil)
        button.layer.add(pulse, forKey: nil)
    }
    
    static func btnActionSize(button: UIButton) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.1
        pulse.fromValue = 1.0
        pulse.toValue = 1.1
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        button.layer.add(pulse, forKey: nil)
    }
}
