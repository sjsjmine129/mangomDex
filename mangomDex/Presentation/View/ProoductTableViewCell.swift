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
    lazy var containerVw: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.cornerRadius = 14
        vw.layer.shadowColor = UIColor.gray.cgColor
        vw.layer.shadowOpacity = 0.8
        vw.layer.shadowRadius = 4
        vw.layer.shadowOffset = CGSize(width: 2, height: 2)
        vw.layer.shadowPath = nil
        
        return vw
    }()
    
    lazy var lblProductName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 20)
        lbl.textColor = UIColor(resource: .textBlack)
        lbl.numberOfLines = 2
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var lblProductPrice: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 18)
        lbl.textColor = UIColor(resource: .magBorder)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var imgVwProduct: UIImageView = {
        let imgV = UIImageView()
        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.layer.cornerRadius = 10
        imgV.clipsToBounds = true
        return imgV
    }()
    
    lazy var vwProductInfo: UIView = {
        let stackView = UIView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var stProductButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        return stackView
    }()
    
    lazy var btnProductFind: ProductButton = {
        let btn = ProductButton(title: "재고 찾기")
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowRadius = 4
        btn.layer.shadowOffset = CGSize(width: 1, height: 1)
        btn.layer.shadowPath = nil
        
        return btn
    }()
    
    
    weak var delegate: ProductTableCellDelegate?
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //code for when cell is not seen reset the state
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.delegate = nil
        self.containerVw.subviews.forEach {$0.removeFromSuperview()}
    }
    
    
    // MARK: - make UI of cell
    func cellConfigure(delegate: ProductTableCellDelegate){
        self.delegate = delegate
        containerVw.backgroundColor = UIColor(resource: .magBody)
        
        self.contentView.backgroundColor = .magClothes
        self.contentView.addSubview(containerVw)
        
        containerVw.addSubview(imgVwProduct)
        containerVw.addSubview(vwProductInfo)
        vwProductInfo.addSubview(lblProductName)
        vwProductInfo.addSubview(lblProductPrice)
        vwProductInfo.addSubview(stProductButtons)
        stProductButtons.addArrangedSubview(btnProductFind)
        
        btnProductFind.addTarget(self, action: #selector(didTapFind(_:)), for: .touchUpInside)
        
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
            lblProductName.trailingAnchor.constraint(equalTo: vwProductInfo.trailingAnchor, constant: 0),
            //lblProductPrice
            lblProductPrice.topAnchor.constraint(equalTo: lblProductName.bottomAnchor, constant: 6),
            lblProductPrice.leadingAnchor.constraint(equalTo: vwProductInfo.leadingAnchor, constant: 4),
            //stProductButtons
            stProductButtons.bottomAnchor.constraint(equalTo: containerVw.bottomAnchor, constant: -12),
            stProductButtons.trailingAnchor.constraint(equalTo: containerVw.trailingAnchor, constant: -12),
        ])
        
    }
    
    //send product data to ViewconTrollers function
    @objc func didTapFind(_ button: ProductButton){
        BtnAction.btnActionAll(button: button)
        delegate?.didTapButton(for: button.cuApplink)
        
    }
    
}
