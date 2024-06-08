//
//  DropDownBtn.swift
//  mangomDex
//
//  Created by 엄승주 on 4/5/24.
//

import Foundation
import UIKit
import DropDown

class DropDownBtn:UIButton{
    let lblDropdownTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HUDdiu150", size: 15)
        label.textColor = UIColor(resource: .textBlack)
        return label
    }()
    
    let imgVwDropDown: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var ddFilter = {
        var dd = DropDown()
        
        dd.dataSource = ["전체 보기", "모은 띠부씰", "없는 띠부씰", "중복 띠부씰", "띠부씰 시즌1", "띠부씰 시즌2", "띠부씰 시즌3"]
        dd.anchorView = self
        dd.textFont = UIFont(name: "HUDdiu150", size: 15) ?? UIFont.systemFont(ofSize: 15)
        dd.backgroundColor = .magBody
        dd.selectionBackgroundColor = .magMouth
        DropDown.startListeningToKeyboard()
        dd.cornerRadius = 5
        dd.bottomOffset = CGPoint(x: -5, y: 45)
        dd.selectRow(at: 0)
        dd.cellHeight = 35
        
        return dd
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(lblDropdownTitle)
        addSubview(imgVwDropDown)
        
        if let image = UIImage(systemName: "chevron.down")?.withTintColor(.textBlack, renderingMode: .alwaysOriginal) {
            imgVwDropDown.image = image
        }
        
        lblDropdownTitle.text = "전체 보기"
        
        NSLayoutConstraint.activate([
            //lblDropdownTitle
            lblDropdownTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            lblDropdownTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            //imgVwDropDown
            imgVwDropDown.trailingAnchor.constraint(equalTo: lblDropdownTitle.leadingAnchor, constant: -5),
            imgVwDropDown.bottomAnchor.constraint(equalTo: bottomAnchor),
            imgVwDropDown.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imgVwDropDown.heightAnchor.constraint(equalToConstant: 15),
            imgVwDropDown.widthAnchor.constraint(equalToConstant: 15),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
