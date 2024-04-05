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
    var sticker : Sticker?
    var container: NSPersistentContainer!
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
        
        //TODO: delete
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
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
        self.sticker = nil
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
        flipAndAdd()
    }
    
    @objc private func longPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            flipAndZero()
        }
    }
    
}

//
extension StickerCollectionViewCell{
    //Flip card and add one
    func flipAndAdd(){
        UIView.transition(with: self, duration: 0.7, options: [.transitionFlipFromLeft], animations: {
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
            
            if newNum == 1{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeCollectionNum"), object: nil)
            }
        }, completion: { (_) in })
        
        
    }
    
    //Flip card and add one
    func flipAndZero(){
        UIView.transition(with: self, duration: 0.7, options: [.transitionFlipFromRight], animations: {
            if self.sticker?.number == 0{
                return
            }
            
            let newNum = 0
            let mode = self.stickerViewModel?.checkSetting()
            if  mode?.fadeMode ?? false {
                self.btnSticker.alpha = 0.5
            }
            
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
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeCollectionNum"), object: nil)
        }, completion: { (_) in })
    }
}
