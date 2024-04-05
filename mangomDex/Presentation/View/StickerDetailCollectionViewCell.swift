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
    lazy var vwContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .magClothes
        
        return vw
    }()
    
    lazy var stButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    lazy var stTitle: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    lazy var vwid: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.cornerRadius = 12
        
        return vw
    }()
    
    lazy var lblId: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica Bold Condensed", size: 16)
        lbl.textColor = .white
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 25)
        lbl.textColor = .textBlack
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var imgVwSticker: UIImageView = {
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
    
    lazy var vwLinkBox: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor =  UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1).cgColor
        
        return view
    }()
    
    lazy var vwImgLink:UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.shadowColor = UIColor.gray.cgColor
        vw.layer.shadowOpacity = 0.5
        vw.layer.shadowRadius = 4
        vw.layer.shadowOffset = CGSize(width: 4, height: 4)
        vw.layer.shadowPath = nil
        
        return vw
    }()
    
    lazy var imgVwLink: UIImageView = {
        let imgVw = UIImageView()
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        imgVw.layer.cornerRadius = 10
        imgVw.clipsToBounds = true
        
        return imgVw
    }()
    
    lazy var stLinkText: UIStackView = {
        let st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .vertical
        st.alignment = .center
        st.spacing = 15
        st.distribution = .equalSpacing
        
        return st
    }()
    
    lazy var lblLinkText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 20)
        lbl.textColor = .textBlack
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    let lblLinkBtnTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HUDdiu150", size: 18)
        label.textColor = UIColor(resource: .textBlack)
        return label
    }()
    
    let imgLinkBtn: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var btnLink: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(lblLinkBtnTitle)
        btn.addSubview(imgLinkBtn)
        btn.backgroundColor = .magBody
        
        btn.layer.cornerRadius = 8
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
    
    lazy var stNumberChange: UIStackView = {
        let st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .horizontal
        st.alignment = .center
        st.spacing = 15
        st.distribution = .fill
        
        return st
    }()
    
    lazy var lblNumber: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 25)
        lbl.textColor = .textBlack
        
        return lbl
    }()
    
    lazy var btnMinus: NumberButton = {
        let btn = NumberButton(type: .minus)
        btn.addTarget(self, action: #selector(numberBtnPress(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var btnPlus: NumberButton = {
        let btn = NumberButton(type: .plus)
        btn.addTarget(self, action: #selector(numberBtnPress(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    var stickerViewModel : StickerViewModel?
    var index = 0
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.vwContainer.subviews.forEach {$0.removeFromSuperview()}
    }
    
    // MARK: - make UI of cell
    func detailCellConfigure(viewModel: StickerViewModel){
        self.stickerViewModel = viewModel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(vwContainer)
        
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
        
        vwContainer.addSubview(stNumberChange)
        stNumberChange.addArrangedSubview(btnMinus)
        stNumberChange.addArrangedSubview(lblNumber)
        stNumberChange.addArrangedSubview(btnPlus)
        
        // Add tap gesture recognizer to imgVwSticker
        imgVwSticker.isUserInteractionEnabled = true
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(imgVwStickerLongPress))
        imgVwSticker.addGestureRecognizer(longPressRecognizer)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imgVwStickerTapped))
        imgVwSticker.addGestureRecognizer(tapGesture)
        
        
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
            stButtons.leadingAnchor.constraint(equalTo:  vwContainer.leadingAnchor, constant: 30),
            stButtons.trailingAnchor.constraint(equalTo:  vwContainer.trailingAnchor, constant: -30),
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
            imgLinkBtn.heightAnchor.constraint(equalToConstant: 20),
            imgLinkBtn.widthAnchor.constraint(equalToConstant: 22),
            imgLinkBtn.topAnchor.constraint(equalTo:  btnLink.topAnchor, constant: 8),
            imgLinkBtn.leadingAnchor.constraint(equalTo:  btnLink.leadingAnchor, constant: 12),
            imgLinkBtn.bottomAnchor.constraint(equalTo:  btnLink.bottomAnchor, constant: -8),
            //lblLinkBtnTitle
            lblLinkBtnTitle.leadingAnchor.constraint(equalTo:  imgLinkBtn.trailingAnchor, constant: 8),
            lblLinkBtnTitle.trailingAnchor.constraint(equalTo:  btnLink.trailingAnchor, constant: -12),
            lblLinkBtnTitle.centerYAnchor.constraint(equalTo: btnLink.centerYAnchor),
            //stNumberChange
            stNumberChange.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            stNumberChange.topAnchor.constraint(equalTo: vwLinkBox.bottomAnchor),
            stNumberChange.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - objc
extension StickerDetailCollectionViewCell{
    @objc private func imgVwStickerTapped() {
        UIView.transition(with: imgVwSticker, duration: 0.7, options: [.transitionFlipFromLeft], animations: {
            self.stickerViewModel?.adjustStickerNum(index: self.index, changeNum: 1, cell: self)
        }, completion: { (_) in
        })
        
    }
    
    @objc private func imgVwStickerLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            UIView.transition(with: imgVwSticker, duration: 0.7, options: [.transitionFlipFromRight], animations: {
                self.stickerViewModel?.adjustStickerNum(index: self.index, changeNum: 0, cell: self)
            }, completion: { (_) in
            })
        }
    }
    
    
    @objc func goToLink(_ button: UIButton){
        BtnAction.btnActionAll(button: button)
        self.stickerViewModel?.openIink(index: index)
    }
    
    @objc func numberBtnPress(_ button: UIButton){
        BtnAction.btnActionAll(button: button)
        
        if(button.tag == 1){
            UIView.transition(with: imgVwSticker, duration: 0.7, options: [.transitionFlipFromLeft], animations: {
                self.stickerViewModel?.adjustStickerNum(index: self.index, changeNum: button.tag, cell: self)
            }, completion: { (_) in
            })
        }else{
            UIView.transition(with: imgVwSticker, duration: 0.7, options: [.transitionFlipFromRight], animations: {
                self.stickerViewModel?.adjustStickerNum(index: self.index, changeNum: button.tag, cell: self)
            }, completion: { (_) in
                
            })
        }
    }
    
}
