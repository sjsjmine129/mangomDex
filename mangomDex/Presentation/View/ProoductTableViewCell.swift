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
        vw.layer.cornerRadius = 14
        return vw
    }()
    
    private lazy var lblProductName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 22)
        lbl.textColor = UIColor(resource: .textBlack)
        lbl.textAlignment = .center
        
//        lbl.backgroundColor = .white
        
        return lbl
    }()
    
    private lazy var lblProductPrice: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 24)
        lbl.textColor = UIColor(resource: .magBorder)
        lbl.textAlignment = .center
        
//        lbl.backgroundColor = .magClothes
        
        return lbl
    }()
    
    private lazy var imgVwProduct: UIImageView = {
        let imgV = UIImageView()
        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.layer.cornerRadius = 10
        imgV.clipsToBounds = true
        return imgV
    }()
    
    private lazy var vwProductInfo: UIView = {
        let stackView = UIView()
//        stackView.backgroundColor = .green
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
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
        
        self.contentView.backgroundColor = .magClothes
        self.contentView.addSubview(containerVw)
        
        imgVwProduct.image = UIImage(named: "\(item.name).jpeg")
        lblProductName.text = item.name
        lblProductPrice.text = "\(item.price)원"
        
        containerVw.addSubview(imgVwProduct)
        containerVw.addSubview(vwProductInfo)
        
        vwProductInfo.addSubview(lblProductName)
        vwProductInfo.addSubview(lblProductPrice)
        
        NSLayoutConstraint.activate([
            //containerVw
            containerVw.topAnchor.constraint(equalTo:  self.contentView.topAnchor, constant: 4),
            containerVw.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant:  -4),
            containerVw.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant: 20),
            containerVw.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: -20),
            //imgVwProduct
            imgVwProduct.topAnchor.constraint(equalTo: containerVw.topAnchor, constant: 8),
            imgVwProduct.bottomAnchor.constraint(equalTo: containerVw.bottomAnchor, constant: -8),
            imgVwProduct.leadingAnchor.constraint(equalTo: containerVw.leadingAnchor, constant: 8),
            imgVwProduct.heightAnchor.constraint(equalToConstant: 150),
            imgVwProduct.widthAnchor.constraint(equalToConstant: 150),
            //vwProductInfo
            vwProductInfo.topAnchor.constraint(equalTo: containerVw.topAnchor, constant: 8),
            vwProductInfo.bottomAnchor.constraint(equalTo: containerVw.bottomAnchor, constant: -8),
            vwProductInfo.leadingAnchor.constraint(equalTo: imgVwProduct.trailingAnchor, constant: 8),
            vwProductInfo.trailingAnchor.constraint(equalTo: containerVw.trailingAnchor, constant: -8),
            //lblProductName
            lblProductName.topAnchor.constraint(equalTo: vwProductInfo.topAnchor, constant: 12),
            lblProductName.leadingAnchor.constraint(equalTo: vwProductInfo.leadingAnchor, constant: 0),
            //lblProductPrice
            lblProductPrice.topAnchor.constraint(equalTo: lblProductName.bottomAnchor, constant: 4),
            lblProductPrice.leadingAnchor.constraint(equalTo: vwProductInfo.leadingAnchor, constant: 4),
        ])
        
    }
    
}
