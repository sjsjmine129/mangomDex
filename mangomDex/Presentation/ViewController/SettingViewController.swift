//
//  SettingViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit

class SettingViewController: UIViewController {
    
    private var settingViewModel = SettingViewModel()
    
    // Title label at the top
    private lazy var lblTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "망그러진 설정"
        title.font = UIFont(name: "HUDdiu150", size: 25)
        title.textColor = UIColor(resource: .textBlack)
        return title
    }()
    
    private var settingView: SettingView!
    
    // MARK - LifeCycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide navigation bar when this screen appears
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}

// MARK: - init page
private extension SettingViewController{
    
    func setUI(){
        settingView = SettingView()
        self.view = settingView
        
        // Add title label on top of the settingView
        self.view.addSubview(lblTitle)
        
        // Bring title to front
        self.view.bringSubviewToFront(lblTitle)
        
        NSLayoutConstraint.activate([
            // Title at top-left corner
            lblTitle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            lblTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
        ])
        
        let setting = settingViewModel.checkSetting()
        settingView.switchFade.isOn = setting.fadeMode
        settingView.switchNum.isOn = setting.numMode
        
        settingView.switchFade.addTarget(self, action: #selector(fadeSwitchValueChanged(_:)), for: .valueChanged)
        settingView.switchNum.addTarget(self, action: #selector(numSwitchValueChanged(_:)), for: .valueChanged)
        settingView.btnBug.addTarget(self, action: #selector(openKakaoInquire(_:)), for: .touchUpInside)
        settingView.btnInsta.addTarget(self, action: #selector(openInstagram(_:)), for: .touchUpInside)
        settingView.btnReset.addTarget(self, action: #selector(showAlert(_:)), for: .touchUpInside)
    }
}

// MARK: - objc
private extension SettingViewController{
    
    @objc func openInstagram(_ button:UIButton){
        BtnAction.btnActionAll(button: button)
        
        if let instagramURL = URL(string: "instagram://user?username=yurang_official") {
            UIApplication.shared.open(instagramURL, options: [:], completionHandler: nil)
        } else {
            let instagramWebURL = URL(string: "https://apps.apple.com/kr/app/instagram/id389801252")!
            UIApplication.shared.open(instagramWebURL, options: [:], completionHandler: nil)
        }
    }
    
    @objc func openKakaoInquire(_ button:UIButton){
        BtnAction.btnActionAll(button: button)
        
        let instagramWebURL = URL(string: "https://open.kakao.com/o/s9QZvhfg")!
        UIApplication.shared.open(instagramWebURL, options: [:], completionHandler: nil)
    }
    
    @objc func fadeSwitchValueChanged(_ sender: UISwitch) {
        settingViewModel.fadeSwitchValueChanged(isOn: sender.isOn)
        settingViewModel.triggerReload()
    }
    
    @objc func numSwitchValueChanged(_ sender: UISwitch) {
        settingViewModel.numSwitchValueChanged(isOn: sender.isOn)
        settingViewModel.triggerReload()
    }
    
    
    //delete data of sticker number
    @objc func showAlert(_ button:UIButton) {
        BtnAction.btnActionAll(button: button)
        
        let alertController = UIAlertController(title: "수집 기록 초기화", message: "수집 데이터를 초기화 하면 모든 띠부씰의 개수가 0으로 초기화됩니다!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let proceedAction = UIAlertAction(title: "초기화", style: .default) { (action) in
            self.settingViewModel.resetStickerData()
        }

        alertController.addAction(cancelAction)
        alertController.addAction(proceedAction)

        self.present(alertController, animated: true, completion: nil)
    }

}


