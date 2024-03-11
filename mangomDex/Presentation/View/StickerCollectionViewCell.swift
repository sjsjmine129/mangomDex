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
    private lazy var containerVw: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
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
        //        self.containerVw.subviews.forEach {$0.removeFromSuperview()}
    }
    
    // MARK: - make UI of cell
    func cellConfigure(with item: Sticker){
        
        self.contentView.addSubview(containerVw)
        
        contentView.addSubview(imgVwsticker)
        imgVwsticker.image = item.image
        imgVwsticker.contentMode = .scaleAspectFit
        
        if item.number == 0 {
            imgVwsticker.alpha = 0.5
        }

        NSLayoutConstraint.activate([
            //containerVw
            containerVw.topAnchor.constraint(equalTo:  self.contentView.topAnchor, constant: 0),
            containerVw.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant:  0),
            containerVw.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant:0),
            containerVw.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: 0),
            //imgVwsticker
            imgVwsticker.topAnchor.constraint(equalTo:  containerVw.topAnchor, constant: 0),
            imgVwsticker.bottomAnchor.constraint(equalTo:  containerVw.bottomAnchor, constant:  0),
            imgVwsticker.leadingAnchor.constraint(equalTo:  containerVw.leadingAnchor, constant: 0),
            imgVwsticker.trailingAnchor.constraint(equalTo:  containerVw.trailingAnchor, constant: 0),
        ])
    }
    
}
