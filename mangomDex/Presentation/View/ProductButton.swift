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

        self.configuration = configuration
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
