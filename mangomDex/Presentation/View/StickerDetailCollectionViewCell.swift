//
//  StickerDetailCollectionViewCell.swift
//  mangomDex
//
//  Created by 엄승주 on 3/16/24.
//

import UIKit

class StickerDetailCollectionViewCell: UICollectionViewCell {
    
    static let id = "StickerDetailCollectionViewCell"

    // MARK: - UI
    private lazy var vwContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .magClothes

        return vw
    }()
    
    private lazy var stButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.distribution = .equalCentering
        
//        stackView.backgroundColor = .magMouth

        return stackView
    }()
    
    private lazy var stTitle: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .equalCentering

        return stackView
    }()
    
    private lazy var vwid: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.cornerRadius = 12
        
        return vw
    }()
    
    private lazy var lblId: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica Bold Condensed", size: 16)
        lbl.textColor = .white
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 25)
        lbl.textColor = .textBlack
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var imgVwSticker: UIImageView = {
        let imgVw = UIImageView()
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        
        imgVw.layer.shadowColor = UIColor.gray.cgColor
        imgVw.layer.shadowOpacity = 0.5
        imgVw.layer.shadowRadius = 4
        imgVw.layer.shadowOffset = CGSize(width: 4, height: 4)
        imgVw.layer.shadowPath = nil
        
        return imgVw
    }()
    
    
    
    // MARK: - make UI of cell
    func detailCellConfigure(with item: Sticker, viewModel: StickerViewModel){
        
        self.addSubview(vwContainer)
        
        vwContainer.addSubview(imgVwSticker)
        
        vwContainer.addSubview(stButtons)
        
        stButtons.addArrangedSubview(stTitle)
        
        stTitle.addArrangedSubview(vwid)
        stTitle.addArrangedSubview(lblTitle)
        vwid.addSubview(lblId)
        vwContainer.addSubview(imgVwSticker)
        
        vwid.backgroundColor = item.color
        lblId.text = viewModel.changeId(id: item.id)
        lblTitle.text = item.name
        
        imgVwSticker.image = item.image
        
        NSLayoutConstraint.activate([
            //contentView
            vwContainer.topAnchor.constraint(equalTo:  self.topAnchor, constant: 0),
            vwContainer.bottomAnchor.constraint(equalTo:  self.bottomAnchor, constant:  0),
            vwContainer.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant:0),
            vwContainer.trailingAnchor.constraint(equalTo:  self.trailingAnchor, constant: 0),
            //imgVwSticker
            imgVwSticker.topAnchor.constraint(equalTo:  vwContainer.topAnchor, constant: 30),
            imgVwSticker.leadingAnchor.constraint(equalTo:  vwContainer.leadingAnchor, constant: 40),
            imgVwSticker.trailingAnchor.constraint(equalTo:  vwContainer.trailingAnchor, constant: -40),
            imgVwSticker.heightAnchor.constraint(equalTo: vwContainer.heightAnchor, multiplier: 0.5),
//            imgVwSticker.bottomAnchor.constraint(equalTo: stButtons.topAnchor, constant: -10),
            //stButtons
            stButtons.leadingAnchor.constraint(equalTo:  vwContainer.leadingAnchor, constant: 30),
            stButtons.trailingAnchor.constraint(equalTo:  vwContainer.trailingAnchor, constant: -30),
            stButtons.topAnchor.constraint(equalTo: imgVwSticker.bottomAnchor, constant: 20),
            //vwid
            vwid.heightAnchor.constraint(equalToConstant: 24),
            vwid.widthAnchor.constraint(equalToConstant: 30),
            //lblId
            lblId.centerXAnchor.constraint(equalTo: vwid.centerXAnchor),
            lblId.centerYAnchor.constraint(equalTo: vwid.centerYAnchor),
            
        ])
    }
    
}
