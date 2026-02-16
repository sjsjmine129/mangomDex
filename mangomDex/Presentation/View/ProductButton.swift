//
//  ProductButton.swift
//  mangomDex
//
//  Created by 엄승주 on 3/6/24.
//

import Foundation
import UIKit

class ProductButton: UIButton{
    
    var cuApplink : String?
    
    init(title: String) {
        super.init(frame: .zero)
        
        // make UI
        var configuration = UIButton.Configuration.plain()
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont(name: "HUDdiu150", size: 15)
        titleContainer.foregroundColor = UIColor(resource: .textBlack)
        
        configuration.attributedTitle = AttributedString(title, attributes: titleContainer)
        configuration.background.backgroundColor = .magMouth
        
        // Glassmorphism: Rounded corners
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 20

        self.configuration = configuration
        
        // Glassmorphism: Add subtle white border
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
