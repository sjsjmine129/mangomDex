//
//  ViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit
import DropDown
import CoreData

class StickerViewController: UIViewController {
    
    // MARK: - UI component
    private let gridFlowLayout: GridCollectionViewFlowLayout = {
        let layout = GridCollectionViewFlowLayout()
        layout.cellSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.gridFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(StickerCollectionViewCell.self, forCellWithReuseIdentifier: "StickerCollectionViewCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lblDropdownTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HUDdiu150", size: 15)
        label.textColor = UIColor(resource: .textBlack)
        return label
    }()
    
    private let imgVwDropDown: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var btnDropdown: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(lblDropdownTitle)
        btn.addSubview(imgVwDropDown)
        
        if let image = UIImage(systemName: "chevron.down")?.withTintColor(.textBlack, renderingMode: .alwaysOriginal) {
            imgVwDropDown.image = image
        }
        
        lblDropdownTitle.text = "전체 보기"
        
        btn.addTarget(self, action: #selector(showDropdown(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var ddFilter = {
        var dd = DropDown()
        
        dd.dataSource = ["전체 보기", "모은 띠부씰", "없는 띠부씰", "띠부씰 시즌1", "띠부씰 시즌2"]
        dd.anchorView = btnDropdown
        dd.textFont = UIFont(name: "HUDdiu150", size: 15) ?? UIFont.systemFont(ofSize: 15)
        dd.backgroundColor = .magBody
        dd.selectionBackgroundColor = .magMouth
        DropDown.startListeningToKeyboard()
        dd.cornerRadius = 5
        dd.bottomOffset = CGPoint(x: -5, y: 45)
        dd.selectRow(at: 0)
        dd.cellHeight = 35
        
        dd.selectionAction = { [unowned self] (index: Int, item: String) in
            lblDropdownTitle.text = item
            
            if let filter = StickerFilter(rawValue: item) {
                self.stickers = stickerViewModel.filteredStickers(condition: filter)
                gridFlowLayout.collectionView?.reloadData()
                
                self.changeImgVwDropDown(name: "chevron.down")
            } else {}
        }
        
        dd.cancelAction = { [weak self] in
            self?.changeImgVwDropDown(name: "chevron.down")
        }
        
        return dd
    }()
    
    private lazy var stNoSticker: UIStackView = {
        let stackView = UIStackView()
        //stackView.backgroundColor = .blue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var imgVwNoSticker: UIImageView = {
        var imgVw = UIImageView()
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        return imgVw
    }()
    
    private lazy var lblNoSticker: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HUDdiu150", size: 20)
        lbl.textColor = UIColor(resource: .textBlack)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var vwBalck: UIView = {
        var vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .black
        vw.alpha = 0.7
        
        return vw
    }()
    
    private lazy var vwOnboarding: UIView = {
        var vwMain = UIView()
        vwMain.translatesAutoresizingMaskIntoConstraints = false
        
        var lblTwoTap = UILabel()
        lblTwoTap.translatesAutoresizingMaskIntoConstraints = false
        lblTwoTap.font = UIFont(name: "Pretendard-SemiBold", size: 30)
        lblTwoTap.textColor = UIColor(resource: .hamWhite)
        lblTwoTap.text = "2번 탭해서\n띠부씰 수집!"
        lblTwoTap.numberOfLines = 2
        lblTwoTap.textAlignment = .left
        
        var lblLongPress = UILabel()
        lblLongPress.translatesAutoresizingMaskIntoConstraints = false
        lblLongPress.font = UIFont(name: "Pretendard-SemiBold", size: 30)
        lblLongPress.textColor = UIColor(resource: .hamWhite)
        lblLongPress.text = "꾹 눌러서\n개수 초기화!"
        lblLongPress.numberOfLines = 2
        lblLongPress.textAlignment = .left
        
        var imgVw04 = UIImageView(image: UIImage(named: "4.jpg"))
        imgVw04.translatesAutoresizingMaskIntoConstraints = false
        imgVw04.contentMode = .scaleAspectFit
        imgVw04.alpha = 0.9
        
        var imgVw24 = UIImageView(image: UIImage(named: "24.jpg"))
        imgVw24.translatesAutoresizingMaskIntoConstraints = false
        imgVw24.contentMode = .scaleAspectFit
        imgVw24.alpha = 0.9
        
        var imgVwPoint1 = UIImageView(image: UIImage(named: "pointing.png"))
        imgVwPoint1.translatesAutoresizingMaskIntoConstraints = false
        imgVwPoint1.contentMode = .scaleAspectFit
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.autoreverse, .repeat], animations: {
            imgVwPoint1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
        
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { timer in
            if imgVwPoint1.alpha == 1{
                imgVwPoint1.alpha = 0
            }
            else{
                imgVwPoint1.alpha = 1
            }
        }
        
        var imgVwPoint2 = UIImageView(image: UIImage(named: "pointing.png"))
        imgVwPoint2.translatesAutoresizingMaskIntoConstraints = false
        imgVwPoint2.contentMode = .scaleAspectFit
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.autoreverse, .repeat], animations: {
            imgVwPoint2.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            imgVwPoint2.alpha = 0.3
        }, completion: nil)
        
        vwMain.addSubview(lblTwoTap)
        vwMain.addSubview(imgVw04)
        vwMain.addSubview(imgVwPoint1)
        vwMain.addSubview(lblLongPress)
        vwMain.addSubview(imgVw24)
        vwMain.addSubview(imgVwPoint2)
        
        NSLayoutConstraint.activate([
            //lblTwoTap
            lblTwoTap.leadingAnchor.constraint(equalTo: vwMain.leadingAnchor),
            //imgVw04
            imgVw04.heightAnchor.constraint(equalToConstant: 130),
            imgVw04.widthAnchor.constraint(equalToConstant: 100),
            imgVw04.leadingAnchor.constraint(equalTo: lblTwoTap.trailingAnchor, constant: 20),
            imgVw04.topAnchor.constraint(equalTo: vwMain.topAnchor, constant: 0),
            imgVw04.bottomAnchor.constraint(equalTo: lblTwoTap.centerYAnchor, constant: 20),
            //imgVwPoint1
            imgVwPoint1.heightAnchor.constraint(equalToConstant: 200),
            imgVwPoint1.widthAnchor.constraint(equalToConstant: 120),
            imgVwPoint1.trailingAnchor.constraint(equalTo: vwMain.trailingAnchor,constant: 0),
            imgVwPoint1.topAnchor.constraint(equalTo: imgVw04.bottomAnchor, constant: -50),
            imgVwPoint1.leadingAnchor.constraint(equalTo: imgVw04.trailingAnchor, constant: -60),
            //imgVw24
            imgVw24.heightAnchor.constraint(equalToConstant: 130),
            imgVw24.widthAnchor.constraint(equalToConstant: 100),
            imgVw24.leadingAnchor.constraint(equalTo: vwMain.leadingAnchor, constant: 10),
            imgVw24.topAnchor.constraint(equalTo: imgVwPoint1.bottomAnchor, constant: -50),
            //imgVwPoint2
            imgVwPoint2.heightAnchor.constraint(equalToConstant: 200),
            imgVwPoint2.widthAnchor.constraint(equalToConstant: 120),
            imgVwPoint2.bottomAnchor.constraint(equalTo: vwMain.bottomAnchor,constant: 0),
            imgVwPoint2.topAnchor.constraint(equalTo: imgVw24.bottomAnchor, constant: -50),
            imgVwPoint2.leadingAnchor.constraint(equalTo: imgVw24.trailingAnchor, constant: -60),
            //lblLongPress
            lblLongPress.centerYAnchor.constraint(equalTo: imgVw24.bottomAnchor, constant: -20),
            lblLongPress.leadingAnchor.constraint(equalTo: imgVwPoint2.trailingAnchor, constant: 0),
            lblLongPress.trailingAnchor.constraint(equalTo: vwMain.trailingAnchor, constant: 0),
        ])
        
        return vwMain
    }()
    
    
    private let lblbtnClose: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HUDdiu150", size: 20)
        label.textColor = UIColor(resource: .textBlack)
        label.text = "띠부씰 모으러 가기!"
        
        return label
    }()
    
    private lazy var btnClose: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(lblbtnClose)
        btn.backgroundColor = .magBody
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1.5
        btn.layer.borderColor = UIColor(resource: .magBorder).cgColor
        
        
        btn.addTarget(self, action: #selector(closeOnBoarding(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            //lblbtnClose
            lblbtnClose.topAnchor.constraint(equalTo: btn.topAnchor, constant: 10),
            lblbtnClose.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 18),
            lblbtnClose.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -18),
            lblbtnClose.bottomAnchor.constraint(equalTo: btn.bottomAnchor, constant: -10),
        ])
        
        return btn
    }()
    
    
    var container: NSPersistentContainer!
    private lazy var stickerViewModel = StickerViewModel()
    lazy var stickers : [Sticker] = []
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataInGridFlowLayout), name: NSNotification.Name(rawValue: "ReloadGridDataNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetStickerNumberData), name: NSNotification.Name(rawValue: "ResetStickerNumberData"), object: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
        let context = container.viewContext
        
        let fetchRequest: NSFetchRequest<StickerNumbers> = StickerNumbers.fetchRequest()
        
        do {
            var coreData = try container.viewContext.fetch(fetchRequest)
            
            if coreData.isEmpty {
                for id in 1...73 {
                    let newData = StickerNumbers(context: context)
                    newData.id = Int16(id)
                    newData.number = 0
                    
                    do {
                        try context.save()
                    } catch {
                        print("Error saving sticker \(id): \(error)")
                    }
                }
                coreData = try container.viewContext.fetch(fetchRequest)
            }
            stickerViewModel.setStoredStickerNumber(coreData: coreData)
            
        } catch {
            print("Error fetching stickers: \(error)")
        }
        
        
        self.stickers = stickerViewModel.filteredStickers(condition: .all)
        setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(resource: .magClothes)
        
        self.view.addSubview(self.collectionView)
        self.view.addSubview(stNoSticker)
        
        stNoSticker.addArrangedSubview(imgVwNoSticker)
        stNoSticker.addArrangedSubview(lblNoSticker)
        
        
        // show onboarding
        if stickerViewModel.onboarding{
            stickerViewModel.onboarding = false
            
            self.view.addSubview(vwBalck)
            self.view.addSubview(vwOnboarding)
            self.view.addSubview(btnClose)
            NSLayoutConstraint.activate([
                //vwBalck
                vwBalck.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                vwBalck.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                vwBalck.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
                vwBalck.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
                //vwOnboarding
                vwOnboarding.centerXAnchor.constraint(equalTo: vwBalck.centerXAnchor),
                vwOnboarding.centerYAnchor.constraint(equalTo: vwBalck.centerYAnchor),
                //btnClose
                btnClose.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                btnClose.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            ])
        }
        
        NSLayoutConstraint.activate([
            //collectionView
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            //lblDropdownTitle
            lblDropdownTitle.trailingAnchor.constraint(equalTo: btnDropdown.trailingAnchor),
            lblDropdownTitle.bottomAnchor.constraint(equalTo: btnDropdown.bottomAnchor),
            //imgVwDropDown
            imgVwDropDown.trailingAnchor.constraint(equalTo: lblDropdownTitle.leadingAnchor, constant: -5),
            imgVwDropDown.bottomAnchor.constraint(equalTo: btnDropdown.bottomAnchor),
            imgVwDropDown.leadingAnchor.constraint(equalTo: btnDropdown.leadingAnchor, constant: 0),
            imgVwDropDown.heightAnchor.constraint(equalToConstant: 15),
            imgVwDropDown.widthAnchor.constraint(equalToConstant: 15),
            //imgVwNoSticker
            imgVwNoSticker.widthAnchor.constraint(equalToConstant: 200),
            //stNoSticker
            stNoSticker.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            stNoSticker.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor,constant: -20),
        ])
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}


// MARK: - set data of grid
extension StickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // show img
        if self.stickers.count == 0 {
            lblNoSticker.isHidden = false
            imgVwNoSticker.isHidden = false
            
            if lblDropdownTitle.text == "모은 띠부씰"{
                imgVwNoSticker.image = UIImage(named: "falling.png")
                lblNoSticker.text = "아직 수집한 띠부씰이 없어요."
                
            }else if lblDropdownTitle.text == "없는 띠부씰"{
                imgVwNoSticker.image = UIImage(named: "all.png")
                lblNoSticker.text = "모든 띠부씰을 다 모았어요!"
            }
        }else{
            lblNoSticker.isHidden = true
            imgVwNoSticker.isHidden = true
        }
        
        return self.stickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sticker = self.stickers[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCollectionViewCell.id, for: indexPath) as! StickerCollectionViewCell
        let setting = stickerViewModel.checkSetting()
        
        cell.cellConfigure(with: sticker, fadeSetting: setting.fadeMode, numSetting: setting.numMode, index: indexPath.row, delegate: self, viewModel: stickerViewModel, colunms: self.gridFlowLayout.numberOfColumns )
        
        return cell
    }
}

extension StickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard
            let flowLayout = collectionViewLayout as? GridCollectionViewFlowLayout,
            flowLayout.numberOfColumns > 0
        else { fatalError() }
        
        let widthOfCells = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        let widthOfSpacing = CGFloat(flowLayout.numberOfColumns - 1) * flowLayout.cellSpacing
        let width = (widthOfCells - widthOfSpacing) / CGFloat(flowLayout.numberOfColumns)
        
        return CGSize(width: width, height: width * CGFloat(flowLayout.ratioHeightToWidth))
    }
}


// MARK: - set navigator
private extension StickerViewController{
    //set navigation Bar UI of sticker tab
    func setNavigationBar(){
        
        let title = UILabel()
        title.text = "망그러진 띠부씰 도감"
        title.font = UIFont(name: "HUDdiu150", size: 25)
        title.textColor = UIColor(resource: .textBlack )
        
        let leftBarBtn = UIBarButtonItem(customView: title)
        let rightBarBtn = UIBarButtonItem(customView: btnDropdown)
        
        navigationItem.leftBarButtonItem = leftBarBtn
        navigationItem.rightBarButtonItem = rightBarBtn
        
        self.navigationController?.navigationBar.frame.size.height = 50
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.barTintColor = .magClothes
    }
}

// MARK: - otherFunc
extension StickerViewController{
    func changeImgVwDropDown(name: String){
        if let image = UIImage(systemName: name)?.withTintColor(.textBlack, renderingMode: .alwaysOriginal) {
            self.imgVwDropDown.image = image
        }
    }
}

// MARK: - objc
extension StickerViewController{
    // show DropDown
    @objc func showDropdown(_ sender: UIButton){
        BtnAction.btnActionSize(button: sender)
        ddFilter.show()
        changeImgVwDropDown(name: "chevron.up")
    }
    
    //reload grid
    @objc func reloadDataInGridFlowLayout() {
        gridFlowLayout.collectionView?.reloadData()
    }
    
    // reset sticker numberData
    @objc func resetStickerNumberData(){
        stickerViewModel.resetNumberToZero()
        gridFlowLayout.collectionView?.reloadData()
    }
    
    // close onBoarding
    @objc func closeOnBoarding(_ sender: UIButton){
        BtnAction.btnActionSize(button: sender)
        self.vwBalck.removeFromSuperview()
        self.vwOnboarding.removeFromSuperview()
        self.btnClose.removeFromSuperview()
    }
}


// MARK: - delegation
extension StickerViewController: StickerGirdCellDelegate{
    func didTapSticker(for index: Int?) {
        if let navigationController = self.navigationController {
            let nextPage = StickerDetailViewController(viewModel: self.stickerViewModel, index: index ?? 0, stickers: self.stickers)
            navigationController.pushViewController(nextPage, animated: true)
        }
    }
}
