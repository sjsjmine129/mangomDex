//
//  StickerCollectionViewCell.swift
//  mangomDex
//
//  Created by 엄승주 on 3/11/24.
//

import UIKit

class StickerCollectionViewCell: UICollectionViewCell {
    static let id = "StickerCollectionViewCell"
    
    // MARK: - UI
    private lazy var btnSticker: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false

        btn.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
            btn.addGestureRecognizer(longPressRecognizer)
        
        return btn
    }()
    
    private var lblCollectNum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HUDdiu150", size: 15)
        label.textColor = UIColor(resource: .textBlack)
        return label
    }()
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - make UI of cell
    func cellConfigure(with item: Sticker, fadeSetting: Bool, numSetting: Bool){
        
        self.contentView.addSubview(btnSticker)
        
        contentView.addSubview(lblCollectNum)
        
        btnSticker.setImage(item.image, for: .normal)
        btnSticker.imageView?.contentMode = .scaleAspectFit
        
        if numSetting {
            lblCollectNum.text = "\(item.number)"
            lblCollectNum.isHidden = false
        }else{
            lblCollectNum.isHidden = true
        }
        
        
        if item.number == 0 && fadeSetting {
            btnSticker.alpha = 0.5
        }else{
            btnSticker.alpha = 0.9
        }
        
        NSLayoutConstraint.activate([
            //btnSticker
            btnSticker.topAnchor.constraint(equalTo:  self.contentView.topAnchor, constant: 0),
            btnSticker.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant:  0),
            btnSticker.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant:0),
            btnSticker.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: 0),
            //lblCollectNum
            lblCollectNum.bottomAnchor.constraint(equalTo:  btnSticker.bottomAnchor, constant: -2),
            lblCollectNum.leadingAnchor.constraint(equalTo:  btnSticker.leadingAnchor, constant: 6),
        ])
    }
    
    @objc private func handleTap(_ sender: UIButton) {
        // Handle regular tap
        print("Button tapped!")
        BtnAction.btnActionSize(button: sender)
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            // Handle long press
            print("Long press detected!")
        }
    }
    
}
