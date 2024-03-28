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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    func cellConfigure(with item: Sticker, fadeSetting: Bool, numSetting: Bool, index: Int, delegate: StickerGirdCellDelegate, viewModel: StickerViewModel, colunms: Int){
        self.stickerViewModel = viewModel
        
        self.delegate = delegate
        self.sticker = item
        
        btnSticker.tag = index
        btnSticker.setImage(item.image, for: .normal)
        
        if numSetting {
            var fontSize = 15
            switch colunms{
            case 2:
                fontSize = 30
            case 3:
                fontSize = 20
            case 4:
                fontSize = 15
            case 5:
                fontSize = 12
            case 6:
                fontSize = 10
            case 7:
                fontSize = 8
            case 8:
                fontSize = 8
            case 9:
                fontSize = 6
            default:
                fontSize = 15
            }
            
            lblCollectNum.font = UIFont(name: "HUDdiu150", size: CGFloat(fontSize))
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
        
    }
    
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
        }, completion: { (_) in })
    }
}
