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
        vw.backgroundColor = .lightGray
        return vw
    }()
    
    private lazy var stTitle: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        
        stackView.backgroundColor = .blue
        return stackView
    }()
    
    private lazy var vwid: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.cornerRadius = 25
        
        return vw
    }()
    
    private lazy var lblId: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica Bold Condensed", size: 30)
        lbl.textColor = .white
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    
    
    // MARK: - make UI of cell
    func detailCellConfigure(with item: Sticker){
        
        self.addSubview(vwContainer)
        
        self.addSubview(stTitle)
        stTitle.addArrangedSubview(vwid)
        vwid.addSubview(lblId)
        
        NSLayoutConstraint.activate([
            //contentView
            vwContainer.topAnchor.constraint(equalTo:  self.topAnchor, constant: 0),
            vwContainer.bottomAnchor.constraint(equalTo:  self.bottomAnchor, constant:  0),
            vwContainer.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant:0),
            vwContainer.trailingAnchor.constraint(equalTo:  self.trailingAnchor, constant: 0),
            //stTitle
            stTitle.topAnchor.constraint(equalTo: self.topAnchor , constant: 0),
            stTitle.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant:  0),
            //vwid
            vwid.heightAnchor.constraint(equalToConstant: 40),
            vwid.widthAnchor.constraint(equalToConstant: 70),
            //lblId
            lblId.centerXAnchor.constraint(equalTo: vwid.centerXAnchor),
            lblId.centerYAnchor.constraint(equalTo: vwid.centerYAnchor),
            
        ])
    }
    
}
