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
    
    private let imgVwsticker: UIImageView = {
        let vw = UIImageView()
        vw.contentMode = .scaleAspectFill
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //code for when cell is not seen reset the state
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // remove data
        self.imgVwsticker.image = nil
        
        //delete ui of not seen
        //        self.vwContainer.subviews.forEach {$0.removeFromSuperview()}
    }
    
    // MARK: - make UI of cell
    func cellConfigure(with item: Sticker){
        
        self.contentView.addSubview(vwContainer)
        
        contentView.addSubview(imgVwsticker)
        imgVwsticker.image = item.image
        imgVwsticker.contentMode = .scaleAspectFit
        
        if item.number == 0 && StickerViewModel.fadeMode {
            imgVwsticker.alpha = 0.5
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
