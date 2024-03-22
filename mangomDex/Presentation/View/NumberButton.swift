//
//  NumberButton.swift
//  mangomDex
//
//  Created by 엄승주 on 3/19/24.
//

import Foundation
import UIKit

enum NumberButtonType {
    case plus
    case minus
}

class NumberButton: UIButton{
    init(type:NumberButtonType) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .magBody
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(resource: .magBorder).cgColor
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowPath = nil
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50),
            self.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        var image: UIImage?
        if type == .plus{
            self.tag = 1
            image = UIImage(systemName: "plus")?.withTintColor(.textBlack, renderingMode: .alwaysOriginal)
        }else if type == .minus{
            self.tag = -1
            image = UIImage(systemName: "minus")?.withTintColor(.textBlack, renderingMode: .alwaysOriginal)
        }
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        

        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
