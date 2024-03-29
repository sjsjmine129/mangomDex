//
//  SettingViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit
import CoreData

class SettingViewController: UIViewController {
    
    private lazy var settingViewModel = SettingViewModel()
    var container: NSPersistentContainer!
    
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
    
    private lazy var btnBug = SettingButton(title: "버그 신고 및 문의", action: #selector(openKakaoInquire) )
    private lazy var btnInsta = SettingButton(title: "망그러진 곰 인스타 바로가기", action: #selector(openInstagram) )
    private lazy var btnFadeStyle = SettingButton(title: "없는 띠부씰 흐리게 표시", action: #selector(test) )
    private lazy var btnCollecNum = SettingButton(title: "모은 개수 표시하기", action: #selector(test) )
    private lazy var btnReset = SettingButton(title: "수집 정보 초기화", action: #selector(showAlert) )
    
    private lazy var imgVwAppIcon: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "icon.png")
        img.layer.cornerRadius = 20
        img.layer.masksToBounds = true
        
        return img
    }()
    
    private lazy var switchFade: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.onTintColor = UIColor(resource: .magBody)
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        sw.transform = scale
        sw.addTarget(self, action: #selector(fadeSwitchValueChanged(_:)), for: .valueChanged)
        
        return sw
    }()
    
    private lazy var switchNum: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.onTintColor = UIColor(resource: .magBody)
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        sw.transform = scale
        sw.addTarget(self, action: #selector(numSwitchValueChanged(_:)), for: .valueChanged)
        
        return sw
    }()
    
    private lazy var stButtonSwitchFade: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    private lazy var stButtonSwitchNum: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    
    // MARK - LifeCycle
    override func loadView() {
        super.loadView()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
        setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(resource: .magClothes)
        
        setUI()
    }
    
}


// MARK: - init page
private extension SettingViewController{
    
    //set navigation Bar UI of setting tab
    func setNavigationBar(){
        
        let title = UILabel()
        title.text = "망그러진 설정"
        title.font = UIFont(name: "HUDdiu150", size: 25)
        title.textColor = UIColor(resource: .textBlack)
        
        let barButton = UIBarButtonItem(customView: title)
        
        navigationItem.leftBarButtonItem = barButton
        
        self.navigationController?.navigationBar.frame.size.height = 50
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.barTintColor = .magClothes
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
        
        stSettingButtons.addArrangedSubview(stButtonSwitchFade)
        stButtonSwitchFade.addArrangedSubview(btnFadeStyle)
        stButtonSwitchFade.addArrangedSubview(switchFade)
        
        stSettingButtons.addArrangedSubview(stButtonSwitchNum)
        stButtonSwitchNum.addArrangedSubview(btnCollecNum)
        stButtonSwitchNum.addArrangedSubview(switchNum)
        
        stSettingButtons.addArrangedSubview(btnReset)
        
        let setting = settingViewModel.checkSetting()
        switchFade.isOn = setting.fadeMode
        switchNum.isOn = setting.numMode
        
        
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
            //stButtonSwitchFade
            stButtonSwitchFade.leadingAnchor.constraint(equalTo: stSettingButtons.leadingAnchor),
            stButtonSwitchFade.trailingAnchor.constraint(equalTo: stSettingButtons.trailingAnchor),
            //stButtonSwitchNum
            stButtonSwitchNum.leadingAnchor.constraint(equalTo: stSettingButtons.leadingAnchor),
            stButtonSwitchNum.trailingAnchor.constraint(equalTo: stSettingButtons.trailingAnchor),
        ])
        
    }
}

// MARK: - objc
private extension SettingViewController{
    @objc func test(_ button: UIButton){

    }
    
    @objc func openInstagram(_ button:UIButton){
        BtnAction.btnActionAll(button: button)
        settingViewModel.openInstagram()
    }
    
    @objc func openKakaoInquire(_ button:UIButton){
        BtnAction.btnActionAll(button: button)
        settingViewModel.openKakaoInquire()
    }
    
    @objc func fadeSwitchValueChanged(_ sender: UISwitch) {
        settingViewModel.fadeSwitchValueChanged(sender: sender)
        settingViewModel.triggerReload()
    }
    
    @objc func numSwitchValueChanged(_ sender: UISwitch) {
        settingViewModel.numSwitchValueChanged(sender: sender)
        settingViewModel.triggerReload()
    }
    
    
    //delete data of sticker number
    @IBAction func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "수집 기록 초기화", message: "수집 데이터를 초기화 하면 모든 띠부씰의 개수가 0으로 초기화됩니다!", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let proceedAction = UIAlertAction(title: "초기화", style: .default) { (action) in
            let context = self.container.viewContext
            let fetchRequest: NSFetchRequest<StickerNumbers> = StickerNumbers.fetchRequest()
            
            do {
                let stickers = try context.fetch(fetchRequest)
                for sticker in stickers {
                    sticker.number = 0
                }
                
                try context.save()
            } catch {
                print("Error updating numbers: \(error)")
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ResetStickerNumberData"), object: nil)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(proceedAction)

        self.present(alertController, animated: true, completion: nil)
    }

    
}


