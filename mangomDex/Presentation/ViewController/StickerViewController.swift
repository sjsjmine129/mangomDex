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
    
    // MARK - LifeCycle
    override func loadView() {
        super.loadView()
        setNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(named: Color.mag_clothes.rawValue)
        
        self.view.addSubview(nameLbl)
        NSLayoutConstraint.activate([
            nameLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }

}

private extension StickerViewController{
    //set navigation Bar UI of sticker tab
    func setNavigationBar(){
        
        let title = UILabel()
        title.text = "망그러진 띠부씰 도감"
        title.font = UIFont(name: "HUDdiu150", size: 30)
        title.textColor = UIColor(named: Color.text_black.rawValue)
        
        let barButton = UIBarButtonItem(customView: title)
        
        navigationItem.leftBarButtonItem = barButton
        
        self.navigationController?.navigationBar.frame.size.height = 50
        self.navigationController?.navigationBar.backgroundColor = .clear
        
        
    }
}
