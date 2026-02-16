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
        
        // Glassmorphism: Apply blur effect background
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 20
        blurView.layer.masksToBounds = true
        blurView.isUserInteractionEnabled = false
        self.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // Glassmorphism: Rounded corners with subtle white border
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        
        // Glassmorphism: Soft shadow for floating effect
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
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
