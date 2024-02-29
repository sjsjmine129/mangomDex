//
//  SettingViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK - LifeCycle
    override func loadView() {
        super.loadView()
        setNavigationBar()
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
}
