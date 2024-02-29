//
//  SettingViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit

class SettingViewController: UIViewController {
    
    private lazy var padView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = UIColor(named: Color.mag_body.rawValue)
        vw.layer.cornerRadius = 10
        
        return vw
    }()
    
    private lazy var appIcon: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "icon.png")
        img.layer.cornerRadius = 20
        img.layer.masksToBounds = true
        
        return img
    }()
    
    // MARK - LifeCycle
    override func loadView() {
        super.loadView()
        setNavigationBar()
        setUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: Color.mag_clothes.rawValue)
        // Do any additional setup after loading the view.
    }

}


private extension SettingViewController{
    //set navigation Bar UI of setting tab
    func setNavigationBar(){
        
        let title = UILabel()
        title.text = "망그러진 설정"
        title.font = UIFont(name: "HUDdiu150", size: 30)
        title.textColor = UIColor(named: Color.text_black.rawValue)
        
        let barButton = UIBarButtonItem(customView: title)
        
        navigationItem.leftBarButtonItem = barButton
        
        self.navigationController?.navigationBar.frame.size.height = 50
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    //set UI
    func setUI(){
        
        self.view.addSubview(padView)
        padView.addSubview(appIcon)
        
        NSLayoutConstraint.activate([
            //padView
            padView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            padView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            padView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            padView.heightAnchor.constraint(equalToConstant: 280),
            //appIcon
            appIcon.topAnchor.constraint(equalTo: padView.topAnchor, constant: 30),
            appIcon.centerXAnchor.constraint(equalTo: padView.centerXAnchor),
            appIcon.heightAnchor.constraint(equalToConstant: 90),
            appIcon.widthAnchor.constraint(equalToConstant: 90),
            
        ])
        
    }
}
