//
//  MainTabBarControllerViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit

class MainTabBarControllerViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let productTab = UINavigationController(rootViewController: ProductViewController())
        let productTabBarItem = UITabBarItem(title: "상품", image: UIImage(systemName: "list.dash"), tag: 0)
        productTab.tabBarItem = productTabBarItem
        
        let stickerTab =  UINavigationController(rootViewController: StickerViewController())
        let stickerTabBarItem = UITabBarItem(title: "띠부씰", image: UIImage(systemName: "square.grid.3x3"), tag: 1)
        stickerTab.tabBarItem = stickerTabBarItem
        
        let settingTab =  UINavigationController(rootViewController: SettingViewController())
        let settingTabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 2)
        settingTab.tabBarItem = settingTabBarItem
        
        self.viewControllers = [productTab, stickerTab, settingTab]
        self.selectedIndex = 2
        
        customizeTabBar()
    }
    
    
    func customizeTabBar() {
        // Change background color
        self.tabBar.backgroundColor = UIColor(resource: .hamWhite)
        
        // Change tab bar item font and font size
        if let font = UIFont(name: "HUDdiu150", size: 12) {
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        }
    }

}
