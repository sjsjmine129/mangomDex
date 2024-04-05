//
//  NoStickerStack.swift
//  mangomDex
//
//  Created by 엄승주 on 4/5/24.
//

import Foundation
import UIKit

class NoStickerStack: UIStackView{
    lazy var imgVwNoSticker: UIImageView = {
        var imgVw = UIImageView()
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        return imgVw
    }()
    
    lazy var lblNoSticker: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 20)
        lbl.textColor = UIColor(resource: .textBlack)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        alignment = .center
        spacing = 10
        
        addArrangedSubview(imgVwNoSticker)
        addArrangedSubview(lblNoSticker)
        
        
        NSLayoutConstraint.activate([
            //imgVwNoSticker
            imgVwNoSticker.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
