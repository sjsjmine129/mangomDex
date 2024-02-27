//
//  ViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit

class StickerViewController: UIViewController {
    
    private lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "HUDdiu150", size: 30)
        lbl.textColor = .white
        lbl.text = "망그러진"
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        for family in UIFont.familyNames {
          print(family)

          for sub in UIFont.fontNames(forFamilyName: family) {
            print("====> \(sub)")
          }
        }
        self.view.backgroundColor = .systemRed
        
        self.view.addSubview(nameLbl)
        NSLayoutConstraint.activate([
            nameLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }


}

