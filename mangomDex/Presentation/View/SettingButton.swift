//
//  SettingButton.swift
//  mangomDex
//
//  Created by 엄승주 on 3/3/24.
//

import Foundation
import UIKit

class SettingButton: UIButton{
    
    init(title: String, action: Selector) {
        super.init(frame: .zero)
        
        // make UI
        var configuration = UIButton.Configuration.plain()
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        titleContainer.foregroundColor = UIColor(resource: .textBlack)
        
        configuration.attributedTitle = AttributedString(title, attributes: titleContainer)
        //configuration.background.backgroundColor = .gray
        configuration.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 12, bottom: 10, trailing: 12)
        
        self.configuration = configuration
        self.addTarget(nil, action: action, for: .touchUpInside)
        
    }
    
    init(title: String) {
        super.init(frame: .zero)
        
        // make UI
        var configuration = UIButton.Configuration.plain()
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        titleContainer.foregroundColor = UIColor(resource: .textBlack)
        
        configuration.attributedTitle = AttributedString(title, attributes: titleContainer)
        //configuration.background.backgroundColor = .gray
        configuration.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 12, bottom: 10, trailing: 12)
        
        self.configuration = configuration
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
