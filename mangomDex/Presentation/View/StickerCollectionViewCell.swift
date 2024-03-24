//
//  StickerCollectionViewCell.swift
//  mangomDex
//
//  Created by 엄승주 on 3/11/24.
//

import UIKit
import CoreData

protocol StickerGirdCellDelegate: AnyObject{
    func didTapSticker(for index: Int?)
}

class StickerCollectionViewCell: UICollectionViewCell {
    static let id = "StickerCollectionViewCell"
    private var sticker : Sticker?
    var container: NSPersistentContainer!
    private var stickerViewModel : StickerViewModel?
    
    // MARK: - UI
    private lazy var btnSticker: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        btn.addGestureRecognizer(longPressRecognizer)
        
        return btn
    }()
    
    private var lblCollectNum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HUDdiu150", size: 15)
        label.textColor = UIColor(resource: .textBlack)
        return label
    }()
    
    private weak var delegate: StickerGirdCellDelegate?
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - make UI of cell
    func cellConfigure(with item: Sticker, fadeSetting: Bool, numSetting: Bool, index: Int, delegate: StickerGirdCellDelegate, viewModel: StickerViewModel){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
        self.delegate = delegate
        self.sticker = item
        self.contentView.addSubview(btnSticker)
        
        contentView.addSubview(lblCollectNum)
        
        btnSticker.tag = index
        btnSticker.setImage(item.image, for: .normal)
        btnSticker.imageView?.contentMode = .scaleAspectFit
        
        if numSetting {
            lblCollectNum.text = "\(item.number)"
            lblCollectNum.isHidden = false
        }else{
            lblCollectNum.isHidden = true
        }
        
        
        if item.number == 0 && fadeSetting {
            btnSticker.alpha = 0.5
        }else{
            btnSticker.alpha = 0.9
        }
        
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
    
    @objc private func handleTap(_ sender: UIButton) {
        // Handle regular tap
        BtnAction.btnActionSize(button: sender)
        delegate?.didTapSticker(for: sender.tag)
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            UIView.transition(with: self, duration: 1.0, options: [.transitionFlipFromLeft], animations: {
                let newNum = (self.sticker?.number ?? 0) + 1
                if newNum >= 100{
                    return
                }
                
                self.btnSticker.alpha = 0.9
                self.sticker?.number = newNum
                self.lblCollectNum.text = "\(newNum)"
                
                self.stickerViewModel?.stickers[self.sticker!.id - 1].number = newNum
                
                let fetchRequest: NSFetchRequest<StickerNumbers> = StickerNumbers.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %d", self.sticker!.id)

                do {
                    let results = try self.container.viewContext.fetch(fetchRequest)
                    if let entity = results.first {
                        entity.number  = Int16(newNum)

                        try self.container.viewContext.save()
                    } else {
                        print("Entity with id 3 not found.")
                    }
                } catch {
                    print("Error fetching entity: \(error)")
                }
            }, completion: { (_) in
               
            })
        }
    }
    
}

