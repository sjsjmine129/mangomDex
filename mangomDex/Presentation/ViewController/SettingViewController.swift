//
//  SettingViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit

class SettingViewController: UIViewController {
    
    private lazy var VwPad: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = UIColor(resource: .magBody)
        vw.layer.cornerRadius = 10
        
        return vw
    }()
    
    private lazy var lblAppName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 25)
        lbl.textColor = UIColor(resource: .magBorder)
        lbl.text = "망그러진 띠부씰 도감"
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblAppVersion: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Pretendard-Medium", size: 13)
        lbl.textColor = UIColor(resource: .magBorder)
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            lbl.text = "앱 버전: \(appVersion)"
        }
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblInfo: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Pretendard-Medium", size: 13)
        lbl.textColor = UIColor(resource: .textFade)
        lbl.numberOfLines = 0
        lbl.text =
        """
        • 이 앱은 비상업적인 팬 메이드 앱 입니다.
        • 망그러진 곰 작가 유랑님께 개발 허가를 받았음을 알립니다.
        • 캐릭터, 이미지의 모든 권한은 주식회사 유랑에 있습니다.
        """
        
        return lbl
    }()
    
    private lazy var stSettingButtons: UIStackView = {
        let stackView = UIStackView()
        //stackView.backgroundColor = .blue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 0

        return stackView
    }()

    private lazy var btnBug: UIButton = {
        
        // make UI
        var configuration = UIButton.Configuration.plain()
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        titleContainer.foregroundColor = UIColor(resource: .textBlack)
        
        configuration.attributedTitle = AttributedString("버그 신고 및 문의", attributes: titleContainer)
        //        configuration.background.backgroundColor = .red
        configuration.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 12, bottom: 8, trailing: 12)
        
        let btn = UIButton(configuration: configuration)
        btn.addTarget(self, action: #selector(test), for: .touchUpInside)
        return btn
    }()
    
    private lazy var btnInsta: UIButton = {
       
        var configuration = UIButton.Configuration.plain()
        
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        titleContainer.foregroundColor = UIColor(resource: .textBlack)
        
        configuration.attributedTitle = AttributedString("망그러진 곰 인스타 바로가기", attributes: titleContainer)
        //        configuration.background.backgroundColor = .red
        configuration.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 12, bottom: 8, trailing: 12)
        
        let btn = UIButton(configuration: configuration)
        
        btn.addTarget(self, action: #selector(test), for: .touchUpInside)
        return btn
    }()
    
    
    private lazy var imgVwAppIcon: UIImageView = {
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
        
        self.view.backgroundColor = UIColor(resource: .magClothes)
        // Do any additional setup after loading the view.
    }
    
}


// init page
private extension SettingViewController{
    //set navigation Bar UI of setting tab
    func setNavigationBar(){
        
        let title = UILabel()
        title.text = "망그러진 설정"
        title.font = UIFont(name: "HUDdiu150", size: 30)
        title.textColor = UIColor(resource: .textBlack)
        
        let barButton = UIBarButtonItem(customView: title)
        
        navigationItem.leftBarButtonItem = barButton
        
        self.navigationController?.navigationBar.frame.size.height = 50
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func setUI(){
        
        self.view.addSubview(VwPad)
        VwPad.addSubview(imgVwAppIcon)
        VwPad.addSubview(lblAppName)
        VwPad.addSubview(lblAppVersion)
        VwPad.addSubview(lblInfo)
        
        self.view.addSubview(stSettingButtons)
        stSettingButtons.addArrangedSubview(btnBug)
        stSettingButtons.addArrangedSubview(btnInsta)
        
        NSLayoutConstraint.activate([
            //VwPad
            VwPad.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            VwPad.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            VwPad.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            //imgVwAppIcon
            imgVwAppIcon.topAnchor.constraint(equalTo: VwPad.topAnchor, constant: 25),
            imgVwAppIcon.centerXAnchor.constraint(equalTo: VwPad.centerXAnchor),
            imgVwAppIcon.heightAnchor.constraint(equalToConstant: 90),
            imgVwAppIcon.widthAnchor.constraint(equalToConstant: 90),
            //lblAppName
            lblAppName.topAnchor.constraint(equalTo: imgVwAppIcon.bottomAnchor, constant: 15),
            lblAppName.centerXAnchor.constraint(equalTo: VwPad.centerXAnchor),
            lblAppName.widthAnchor.constraint(equalToConstant: 250),
            //lblAppVersion
            lblAppVersion.topAnchor.constraint(equalTo: lblAppName.bottomAnchor, constant: 8),
            lblAppVersion.centerXAnchor.constraint(equalTo: VwPad.centerXAnchor),
            lblAppVersion.widthAnchor.constraint(equalToConstant: 150),
            //lblInfo
            lblInfo.topAnchor.constraint(equalTo: lblAppVersion.bottomAnchor, constant: 15),
            lblInfo.leadingAnchor.constraint(equalTo: self.VwPad.leadingAnchor, constant: 20),
            lblInfo.trailingAnchor.constraint(equalTo: self.VwPad.trailingAnchor, constant: -20),
            lblInfo.bottomAnchor.constraint(equalTo: VwPad.bottomAnchor, constant: -25),
            //stSettingButtons
            stSettingButtons.topAnchor.constraint(equalTo: self.VwPad.bottomAnchor, constant: 15),
            stSettingButtons.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stSettingButtons.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            //            //btnBug
            //            btnBug.heightAnchor.constraint(equalToConstant: 34),
            //            //btnInsta
            //            btnInsta.heightAnchor.constraint(equalToConstant: 34),
        ])
        
    }
}

private extension SettingViewController{
    @objc func test(_ button: UIButton){
        print("### \(button.titleLabel?.text!)")
    }
}


