//
//  SettingView.swift
//  mangomDex
//
//  Created by 엄승주 on 4/5/24.
//

import Foundation
import UIKit

class SettingView: UIView{
    
    // MARK: - inside UI
    lazy var VwPad: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = UIColor(resource: .magBody)
        vw.layer.cornerRadius = 10
        
        return vw
    }()
    
    lazy var lblAppName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 25)
        lbl.textColor = UIColor(resource: .magBorder)
        lbl.text = "망그러진 띠부씰 도감"
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy var lblAppVersion: UILabel = {
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
    
    lazy var lblInfo: UILabel = {
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
    
    lazy var stSettingButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 0
        
        return stackView
    }()
    
    lazy var btnBug = SettingButton(title: "버그 신고 및 문의")
    lazy var btnInsta = SettingButton(title: "망그러진 곰 인스타 바로가기" )
    lazy var btnFadeStyle = SettingButton(title: "없는 띠부씰 흐리게 표시" )
    lazy var btnCollecNum = SettingButton(title: "모은 개수 표시하기" )
    lazy var btnReset = SettingButton(title: "수집 정보 초기화" )
    
    
    lazy var imgVwAppIcon: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "icon.png")
        img.layer.cornerRadius = 20
        img.layer.masksToBounds = true
        
        return img
    }()
    
    lazy var switchFade: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.onTintColor = UIColor(resource: .magBody)
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        sw.transform = scale
        
        return sw
    }()
    
    lazy var switchNum: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.onTintColor = UIColor(resource: .magBody)
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        sw.transform = scale
        
        return sw
    }()
    
    lazy var stButtonSwitchFade: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    lazy var stButtonSwitchNum: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .magClothes
        addSubview(VwPad)
        VwPad.addSubview(imgVwAppIcon)
        VwPad.addSubview(lblAppName)
        VwPad.addSubview(lblAppVersion)
        VwPad.addSubview(lblInfo)
        
        addSubview(stSettingButtons)
        stSettingButtons.addArrangedSubview(btnBug)
        stSettingButtons.addArrangedSubview(btnInsta)
        
        stSettingButtons.addArrangedSubview(stButtonSwitchFade)
        stButtonSwitchFade.addArrangedSubview(btnFadeStyle)
        stButtonSwitchFade.addArrangedSubview(switchFade)
        
        stSettingButtons.addArrangedSubview(stButtonSwitchNum)
        stButtonSwitchNum.addArrangedSubview(btnCollecNum)
        stButtonSwitchNum.addArrangedSubview(switchNum)
        
        stSettingButtons.addArrangedSubview(btnReset)
        
        
        NSLayoutConstraint.activate([
            //VwPad
            VwPad.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            VwPad.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            VwPad.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
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
            lblInfo.leadingAnchor.constraint(equalTo: VwPad.leadingAnchor, constant: 20),
            lblInfo.trailingAnchor.constraint(equalTo: VwPad.trailingAnchor, constant: -20),
            lblInfo.bottomAnchor.constraint(equalTo: VwPad.bottomAnchor, constant: -25),
            //stSettingButtons
            stSettingButtons.topAnchor.constraint(equalTo: VwPad.bottomAnchor, constant: 15),
            stSettingButtons.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stSettingButtons.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            //stButtonSwitchFade
            stButtonSwitchFade.leadingAnchor.constraint(equalTo: stSettingButtons.leadingAnchor),
            stButtonSwitchFade.trailingAnchor.constraint(equalTo: stSettingButtons.trailingAnchor),
            //stButtonSwitchNum
            stButtonSwitchNum.leadingAnchor.constraint(equalTo: stSettingButtons.leadingAnchor),
            stButtonSwitchNum.trailingAnchor.constraint(equalTo: stSettingButtons.trailingAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
