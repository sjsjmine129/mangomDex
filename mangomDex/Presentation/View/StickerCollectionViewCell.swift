//
//  StickerCollectionViewCell.swift
//  mangomDex
//
//  Created by 엄승주 on 3/11/24.
//

import UIKit

class StickerCollectionViewCell: UICollectionViewCell {
    static let id = "StickerCollectionViewCell"
    
    private var sticker: Sticker?
    
    // MARK: - UI
    private lazy var vwContainer: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
            btn.addGestureRecognizer(longPressRecognizer)
        
        return btn
    }()
    
    private var imgVwsticker: UIImageView = {
        let vw = UIImageView()
        vw.contentMode = .scaleAspectFill
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
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
    
    //code for when cell is not seen reset the state
    override func prepareForReuse() {
        super.prepareForReuse()

        self.vwContainer.subviews.forEach {$0.removeFromSuperview()}
    }
    
    // MARK: - make UI of cell
    func cellConfigure(with item: Sticker, fadeSetting: Bool, numSetting: Bool){
        
        self.contentView.addSubview(vwContainer)
        
        contentView.addSubview(imgVwsticker)
        contentView.addSubview(lblCollectNum)
        
        imgVwsticker.image = item.image
        imgVwsticker.contentMode = .scaleAspectFit
        
        if numSetting {
            lblCollectNum.text = "\(item.number)"
            lblCollectNum.isHidden = false
        }else{
            lblCollectNum.isHidden = true
        }
        
        
        if item.number == 0 && fadeSetting {
            imgVwsticker.alpha = 0.5
        }else{
            imgVwsticker.alpha = 0.9
        }
        
        NSLayoutConstraint.activate([
            //vwContainer
            vwContainer.topAnchor.constraint(equalTo:  self.contentView.topAnchor, constant: 0),
            vwContainer.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant:  0),
            vwContainer.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant:0),
            vwContainer.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: 0),
            //imgVwsticker
            imgVwsticker.topAnchor.constraint(equalTo:  vwContainer.topAnchor, constant: 0),
            imgVwsticker.bottomAnchor.constraint(equalTo:  vwContainer.bottomAnchor, constant:  0),
            imgVwsticker.leadingAnchor.constraint(equalTo:  vwContainer.leadingAnchor, constant: 0),
            imgVwsticker.trailingAnchor.constraint(equalTo:  vwContainer.trailingAnchor, constant: 0),
            //lblCollectNum
            lblCollectNum.bottomAnchor.constraint(equalTo:  vwContainer.bottomAnchor, constant: -2),
            lblCollectNum.leadingAnchor.constraint(equalTo:  vwContainer.leadingAnchor, constant: 6),
        ])
    }
    
    @objc private func handleTap(_ sender: UIButton) {
        // Handle regular tap
        print("Button tapped!")
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            // Handle long press
            print("Long press detected!")
        }
    }
    
}
