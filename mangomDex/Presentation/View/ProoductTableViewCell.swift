//
//  ProoductTableViewCell.swift
//  mangomDex
//
//  Created by 엄승주 on 3/3/24.
//

import UIKit

protocol ProductTableCellDelegate: AnyObject{
    func didTapButton(for CUlink: String?)
}


class ProoductTableViewCell: UITableViewCell {
    
    static let cellId = "ProductTableViewCell"
    
    // MARK: - UI
    private lazy var containerVw: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.cornerRadius = 14
        //        vw.layer.shadowColor = UIColor.gray.cgColor
        //        vw.layer.shadowOpacity = 0.8
        //        vw.layer.shadowRadius = 4
        //        vw.layer.shadowOffset = CGSize(width: 2, height: 2)
        //        vw.layer.shadowPath = nil
        
        return vw
    }()
    
    
    private lazy var lblProductName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 20)
        lbl.textColor = UIColor(resource: .textBlack)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblProductPrice: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 15)
        lbl.textColor = UIColor(resource: .magBorder)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblProductPriceTag: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 15)
        lbl.textColor = UIColor(resource: .magBorder)
        lbl.text = "원"
        lbl.textAlignment = .center
        
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var stProductButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var btnProductDetail: ProductButton = {
        let btn = ProductButton(title: "상품 상세")
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowRadius = 4
        btn.layer.shadowOffset = CGSize(width: 1, height: 1)
        btn.layer.shadowPath = nil
        
        return btn
    }()
    
    private lazy var btnProductFind: ProductButton = {
        let btn = ProductButton(title: "재고 찾기")
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowRadius = 4
        btn.layer.shadowOffset = CGSize(width: 1, height: 1)
        btn.layer.shadowPath = nil
        
        return btn
    }()
    
    
    private weak var delegate: ProductTableCellDelegate?
    private var product: Product?
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //code for when cell is not seen reset the state
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // remove data
        self.product = nil
        self.delegate = nil
        
        //delete ui of not seen
        self.containerVw.subviews.forEach {$0.removeFromSuperview()}
    }
    
    
    // MARK: - make UI of cell
    func cellConfigure(with item: Product, delegate: ProductTableCellDelegate){
        
        self.product = item
        self.delegate = delegate
        
        containerVw.backgroundColor = UIColor(resource: .magBody)
        
        self.contentView.backgroundColor = .magClothes
        self.contentView.addSubview(containerVw)
        
        btnProductFind.addTarget(self, action: #selector(didTapFind(_:)), for: .touchUpInside)
        btnProductDetail.addTarget(self, action: #selector(didTapDetail(_:)), for: .touchUpInside)
        
        
        imgVwProduct.image = UIImage(named: "\(item.name).jpeg")
        lblProductName.text = item.name
        lblProductPrice.text = "\(item.price)"
        
        btnProductFind.cuApplink = item.findLink
        btnProductDetail.cuApplink = item.productLink
        
        containerVw.addSubview(imgVwProduct)
        containerVw.addSubview(vwProductInfo)
        
        vwProductInfo.addSubview(lblProductName)
        vwProductInfo.addSubview(lblProductPrice)
        vwProductInfo.addSubview(lblProductPriceTag)
        vwProductInfo.addSubview(stProductButtons)
        
        stProductButtons.addArrangedSubview(btnProductDetail)
        stProductButtons.addArrangedSubview(btnProductFind)
        
        if item.findLink == nil {
            btnProductFind.isHidden = true
        }
        if item.productLink == nil {
            btnProductDetail.isHidden = true
        }
        
        
        NSLayoutConstraint.activate([
            //containerVw
            containerVw.topAnchor.constraint(equalTo:  self.contentView.topAnchor, constant: 6),
            containerVw.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant:  -6),
            containerVw.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant: 16),
            containerVw.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: -16),
            //imgVwProduct
            imgVwProduct.topAnchor.constraint(equalTo: containerVw.topAnchor, constant: 8),
            imgVwProduct.bottomAnchor.constraint(equalTo: containerVw.bottomAnchor, constant: -8),
            imgVwProduct.leadingAnchor.constraint(equalTo: containerVw.leadingAnchor, constant: 8),
            imgVwProduct.heightAnchor.constraint(equalToConstant: 100),
            imgVwProduct.widthAnchor.constraint(equalToConstant: 100),
            //vwProductInfo
            vwProductInfo.topAnchor.constraint(equalTo: containerVw.topAnchor, constant: 8),
            vwProductInfo.bottomAnchor.constraint(equalTo: containerVw.bottomAnchor, constant: -8),
            vwProductInfo.leadingAnchor.constraint(equalTo: imgVwProduct.trailingAnchor, constant: 8),
            vwProductInfo.trailingAnchor.constraint(equalTo: containerVw.trailingAnchor, constant: -8),
            //lblProductName
            lblProductName.topAnchor.constraint(equalTo: vwProductInfo.topAnchor, constant: 8),
            lblProductName.leadingAnchor.constraint(equalTo: vwProductInfo.leadingAnchor, constant: 0),
            //lblProductPrice
            lblProductPrice.topAnchor.constraint(equalTo: lblProductName.bottomAnchor, constant: 4),
            lblProductPrice.leadingAnchor.constraint(equalTo: vwProductInfo.leadingAnchor, constant: 4),
            //lblProductPriceTag
            lblProductPriceTag.bottomAnchor.constraint(equalTo: lblProductPrice.bottomAnchor, constant: 0),
            lblProductPriceTag.leadingAnchor.constraint(equalTo: lblProductPrice.trailingAnchor, constant: 0),
            //stProductButtons
            stProductButtons.bottomAnchor.constraint(equalTo: containerVw.bottomAnchor, constant: -8),
            stProductButtons.leadingAnchor.constraint(equalTo: imgVwProduct.trailingAnchor, constant: 8),
            stProductButtons.trailingAnchor.constraint(equalTo: containerVw.trailingAnchor, constant: -8),
        ])
        
    }
    
    //send product data to ViewconTrollers function
    @objc func didTapFind(_ button: UIButton){
        BtnAction.btnActionAll(button: button)
        if let product = product{
            delegate?.didTapButton(for: product.findLink)
        }
    }
    
    //send product data to ViewconTrollers function
    @objc func didTapDetail(_ button: UIButton){
        BtnAction.btnActionAll(button: button)
        if let product = product{
            delegate?.didTapButton(for: product.productLink)
        }
    }
    
}
