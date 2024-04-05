//
//  SettingViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit
import CoreData

class SettingViewController: UIViewController {
    
    private var settingViewModel = SettingViewModel()
    
    // MARK - LifeCycle
    override func loadView() {
        super.loadView()
        setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let settingView = SettingView()
        self.view = settingView
        
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


