//
//  StickerTitle.swift
//  mangomDex
//
//  Created by 엄승주 on 4/5/24.
//

import Foundation
import UIKit

class StickerTitle: UIView{
    lazy var lblTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "망그러진 띠부씰"
        title.font = UIFont(name: "HUDdiu150", size: 25)
        title.textColor = UIColor(resource: .textBlack )
        
        return title
    }()
    
    lazy var lblStickerNum: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 20)
        lbl.textColor = UIColor(resource: .textBlack)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lblTitle)
        addSubview(lblStickerNum)
        
        NSLayoutConstraint.activate([
            //lblTitle
            lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            lblTitle.topAnchor.constraint(equalTo: topAnchor),
            lblTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            //lblStickerNum
            lblStickerNum.trailingAnchor.constraint(equalTo: trailingAnchor),
            lblStickerNum.bottomAnchor.constraint(equalTo: bottomAnchor),
            lblStickerNum.leadingAnchor.constraint(equalTo: lblTitle.trailingAnchor, constant: 10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
