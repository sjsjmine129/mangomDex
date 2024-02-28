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
    

    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let productTab = UINavigationController(rootViewController: ProductViewController())
        let productTabBarItem = UITabBarItem(title: "상품", image: UIImage(systemName: "list.dash"), tag: 0)
        productTab.tabBarItem = productTabBarItem
        
        let stickerTab =  UINavigationController(rootViewController: StickerViewController())
        let stickerTabBarItem = UITabBarItem(title: "띠부씰", image: UIImage(systemName: "square.grid.3x3"), tag: 1)
        stickerTab.tabBarItem = stickerTabBarItem
        
        let settingTab =  UINavigationController(rootViewController: StickerViewController())
        let settingTabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 2)
        settingTab.tabBarItem = settingTabBarItem
        
        self.viewControllers = [productTab, stickerTab, settingTab]
        self.selectedIndex = 1
        
        customizeTabBar()
    }
    
    func customizeTabBar() {
        
        // Auto layout, variables, and unit scale are not yet supported
//        var view = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: 393, height: 50)
//        view.layer.backgroundColor = UIColor(red: 0.961, green: 0.953, blue: 0.98, alpha: 1).cgColor
//
//        var parent = self.view!
//        parent.addSubview(view)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.widthAnchor.constraint(equalToConstant: 393).isActive = true
//        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
//        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 802).isActive = true

        // Change background color
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .systemCyan
        
        // Change selected item color
        self.tabBar.tintColor = .black
        
        // Change unselected item color
        self.tabBar.unselectedItemTintColor = .gray
        
        // Change tab bar item font and font size
        if let font = UIFont(name: "Helvetica", size: 12) {
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        }
    }

}
