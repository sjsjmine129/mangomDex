//
//  ProoductTableViewCell.swift
//  mangomDex
//
//  Created by 엄승주 on 3/3/24.
//

import UIKit

class ProoductTableViewCell: UITableViewCell {
    
    static let cellId = "ProductTableViewCell"
    
    // MARK: - UI
    private lazy var containerVw: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private lazy var lblProductName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 20)
        lbl.textColor = UIColor(resource: .magBorder)
//        lbl.text = "테스트"
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private var product: Product?
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        containerVw.layer.cornerRadius = 10
    }
    
    //code for when cell is not seen reset the state
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // remove data
        self.product = nil
        
        //delete ui of not seen
        self.containerVw.subviews.forEach {$0.removeFromSuperview()}
    }
    
    
    // MARK: - make UI of cell
    func cellConfigure(with item: Product){
        self.product = item
        
        containerVw.backgroundColor = UIColor(resource: .magBody)
        
        self.contentView.backgroundColor = .blue
        self.contentView.addSubview(containerVw)
        
        lblProductName.text = item.name
        
        containerVw.addSubview(lblProductName)
        
        
        NSLayoutConstraint.activate([
            containerVw.topAnchor.constraint(equalTo:  self.contentView.topAnchor, constant: 8),
            containerVw.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant:  -8),
            containerVw.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant: 8),
            containerVw.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: -8),
            
            lblProductName.topAnchor.constraint(equalTo: containerVw.topAnchor),
            lblProductName.bottomAnchor.constraint(equalTo: containerVw.bottomAnchor),
        ])
        
    }
    
}
