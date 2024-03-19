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
    
    private lazy var vwLinkBox: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor =  UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1).cgColor
        
        return view
    }()
    
    private lazy var vwImgLink:UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.shadowColor = UIColor.gray.cgColor
        vw.layer.shadowOpacity = 0.5
        vw.layer.shadowRadius = 4
        vw.layer.shadowOffset = CGSize(width: 4, height: 4)
        vw.layer.shadowPath = nil
        
        return vw
    }()
    
    private lazy var imgVwLink: UIImageView = {
        let imgVw = UIImageView()
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        imgVw.layer.cornerRadius = 10
        imgVw.clipsToBounds = true
        
        return imgVw
    }()
    
    private lazy var stLinkText: UIStackView = {
        let st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .vertical
        st.alignment = .center
        st.spacing = 15
        st.distribution = .equalSpacing
        
        return st
    }()
    
    private lazy var lblLinkText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 20)
        lbl.textColor = .textBlack
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    private let lblLinkBtnTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HUDdiu150", size: 20)
        label.textColor = UIColor(resource: .textBlack)
        return label
    }()
    
    private let imgLinkBtn: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var btnLink: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(lblLinkBtnTitle)
        btn.addSubview(imgLinkBtn)
        btn.backgroundColor = .magBody
        
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1.5
        btn.layer.borderColor = UIColor(resource: .magBorder).cgColor
        
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowRadius = 4
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowPath = nil
        
        btn.addTarget(self, action: #selector(goToLink), for: .touchUpInside)
        
        return btn
    }()
    
    var stickerViewModel : StickerViewModel?
    var goLink : String?
    var linkType : LinkType?
    
    // MARK: - make UI of cell
    func detailCellConfigure(with item: Sticker, viewModel: StickerViewModel){
        self.stickerViewModel = viewModel
        self.addSubview(vwContainer)
        self.goLink = item.stickerLink
        self.linkType = item.linkType
        
        vwContainer.addSubview(imgVwSticker)
        
        vwContainer.addSubview(stButtons)
        
        stButtons.addArrangedSubview(stTitle)
        
        stTitle.addArrangedSubview(vwid)
        stTitle.addArrangedSubview(lblTitle)
        vwid.addSubview(lblId)
        
        vwContainer.addSubview(vwLinkBox)
        vwLinkBox.addSubview(vwImgLink)
        vwImgLink.addSubview(imgVwLink)
        vwLinkBox.addSubview(stLinkText)
        
        stLinkText.addArrangedSubview(lblLinkText)
        stLinkText.addArrangedSubview(btnLink)
        
        // set data
        vwid.backgroundColor = item.color
        lblId.text = viewModel.changeId(id: item.id)
        lblTitle.text = item.name
        
        imgVwSticker.image = item.image
        imgVwLink.image = item.linkImage
        
        if let range = item.name.range(of: "망그러진") {
            let trimmedText = String(item.name[range.lowerBound...])
            
            if item.linkType == .insta {
                lblLinkText.text = "\(trimmedText)을\n인스타툰에서 만나요!"
                imgLinkBtn.image = UIImage(named: "Instagram.png")
                lblLinkBtnTitle.text = "인스타툰 보기"
            }else if item.linkType == .kakao{
                lblLinkText.text = "\(trimmedText)을\n이모티콘으로 만나요!"
                imgLinkBtn.image = UIImage(named: "kakao.png")
                lblLinkBtnTitle.text = "이모티콘 보기"
            }
        }
        
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
            //stButtons
            stButtons.leadingAnchor.constraint(equalTo:  vwContainer.leadingAnchor, constant: 35),
            stButtons.trailingAnchor.constraint(equalTo:  vwContainer.trailingAnchor, constant: -35),
            stButtons.topAnchor.constraint(equalTo: imgVwSticker.bottomAnchor, constant: 30),
            //vwid
            vwid.heightAnchor.constraint(equalToConstant: 24),
            vwid.widthAnchor.constraint(equalToConstant: 30),
            //lblId
            lblId.centerXAnchor.constraint(equalTo: vwid.centerXAnchor),
            lblId.centerYAnchor.constraint(equalTo: vwid.centerYAnchor),
            //vwLinkBox
            vwLinkBox.topAnchor.constraint(equalTo:  stButtons.bottomAnchor, constant: 20),
            vwLinkBox.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            //imgVwLink
            imgVwLink.topAnchor.constraint(equalTo:  vwLinkBox.topAnchor, constant: 12),
            imgVwLink.leadingAnchor.constraint(equalTo:  vwLinkBox.leadingAnchor, constant: 12),
            imgVwLink.bottomAnchor.constraint(equalTo:  vwLinkBox.bottomAnchor, constant: -12),
            imgVwLink.heightAnchor.constraint(equalToConstant: 120),
            imgVwLink.widthAnchor.constraint(equalToConstant: 120),
            //stLinkText
            stLinkText.leadingAnchor.constraint(equalTo:  imgVwLink.trailingAnchor, constant: 12),
            stLinkText.trailingAnchor.constraint(equalTo:  vwLinkBox.trailingAnchor, constant: -12),
            stLinkText.centerYAnchor.constraint(equalTo: vwLinkBox.centerYAnchor),
            //imgLinkBtn
            imgLinkBtn.heightAnchor.constraint(equalToConstant: 30),
            imgLinkBtn.widthAnchor.constraint(equalToConstant: 30),
            imgLinkBtn.topAnchor.constraint(equalTo:  btnLink.topAnchor, constant: 8),
            imgLinkBtn.leadingAnchor.constraint(equalTo:  btnLink.leadingAnchor, constant: 12),
            imgLinkBtn.bottomAnchor.constraint(equalTo:  btnLink.bottomAnchor, constant: -8),
            //lblLinkBtnTitle
            lblLinkBtnTitle.leadingAnchor.constraint(equalTo:  imgLinkBtn.trailingAnchor, constant: 8),
            lblLinkBtnTitle.trailingAnchor.constraint(equalTo:  btnLink.trailingAnchor, constant: -12),
            lblLinkBtnTitle.centerYAnchor.constraint(equalTo: btnLink.centerYAnchor),
        ])
    }
    
}

//MARK: - objc
extension StickerDetailCollectionViewCell{
    @objc func goToLink(_ button: UIButton){
        BtnAction.btnActionAll(button: button)
        self.stickerViewModel?.openIink(url: self.goLink ?? "", type: self.linkType ?? .kakao)
    }
}
