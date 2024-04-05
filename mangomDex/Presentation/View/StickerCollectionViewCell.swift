//
//  StickerCollectionViewCell.swift
//  mangomDex
//
//  Created by 엄승주 on 3/11/24.
//

import UIKit

protocol StickerGirdCellDelegate: AnyObject{
    func didTapSticker(for index: Int?)
}

class StickerCollectionViewCell: UICollectionViewCell {
    static let id = "StickerCollectionViewCell"
    private var stickerViewModel : StickerViewModel?
    private weak var delegate: StickerGirdCellDelegate?
    
    // MARK: - UI
    lazy var btnSticker: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        btn.addGestureRecognizer(longPressRecognizer)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        btn.addGestureRecognizer(tapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        btn.addGestureRecognizer(doubleTapGesture)
        
        tapGesture.require(toFail: doubleTapGesture)
        
        return btn
    }()
    
    var lblCollectNum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HUDdiu150", size: 15)
        label.textColor = UIColor(resource: .textBlack)
        return label
    }()
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(btnSticker)
        self.contentView.addSubview(lblCollectNum)
        
        btnSticker.imageView?.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            //btnSticker
            btnSticker.topAnchor.constraint(equalTo:  self.contentView.topAnchor, constant: 0),
            btnSticker.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant:  0),
            btnSticker.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant:0),
            btnSticker.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: 0),
            //lblCollectNum
            lblCollectNum.bottomAnchor.constraint(equalTo:  btnSticker.bottomAnchor, constant: -2),
            lblCollectNum.leadingAnchor.constraint(equalTo:  btnSticker.leadingAnchor, constant: 6),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    // MARK: - make UI of cell
    func cellConfigure(delegate: StickerGirdCellDelegate, viewModel: StickerViewModel){
        self.delegate = delegate
        self.stickerViewModel = viewModel
    }
}

// MARK: - objc
extension StickerCollectionViewCell{
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        guard let button = sender.view as? UIButton else {
            return
        }
        BtnAction.btnActionSize(button: button)
        delegate?.didTapSticker(for: button.tag)
    }
    
    @objc private func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        guard let button = sender.view as? UIButton else {
            return
        }
        BtnAction.btnActionSize(button: button)
        
        UIView.transition(with: self, duration: 0.7, options: [.transitionFlipFromLeft], animations: {
            self.stickerViewModel?.addStickerNum(index: self.btnSticker.tag, cell: self)
        }, completion: { (_) in })
    }
    
    @objc private func longPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            UIView.transition(with: self, duration: 0.7, options: [.transitionFlipFromRight], animations: {
                self.stickerViewModel?.zeroStickerNum(index: self.btnSticker.tag, cell: self)
            }, completion: { (_) in })
        }
    }
}


