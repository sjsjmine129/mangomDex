//
//  ViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit
import DropDown


class StickerViewController: UIViewController {
    
    // MARK: - UI component
    private let gridFlowLayout: GridCollectionViewFlowLayout = {
        let layout = GridCollectionViewFlowLayout()
        layout.cellSpacing = 4
        layout.numberOfColumns = 4
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
        
        btn.addTarget(self, action: #selector(showDropdown), for: .touchUpInside)
        
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
        
        // when select lisr
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
    
    private lazy var stickerViewModel = StickerViewModel()
    lazy var stickers : [Sticker] = []
    
    // MARK - LifeCycle
    override func loadView() {
        super.loadView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataInGridFlowLayout), name: NSNotification.Name(rawValue: "ReloadGridDataNotification"), object: nil)
        
        setNavigationBar()
        self.stickers = stickerViewModel.filteredStickers(condition: .all)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(resource: .magClothes)
        
        self.view.addSubview(self.collectionView)
        
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
            imgVwDropDown.widthAnchor.constraint(equalToConstant: 15)
            
        ])
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
}


// MARK: - set data of grid
extension StickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.stickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sticker = self.stickers[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCollectionViewCell.id, for: indexPath) as! StickerCollectionViewCell
        
        let setting = stickerViewModel.checkSetting()
        
        cell.cellConfigure(with: sticker, fadeSetting: setting.fadeMode, numSetting: setting.numMode)
        
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
    @objc func showDropdown(){
        ddFilter.show()
        changeImgVwDropDown(name: "chevron.up")
    }

    //reload grid
    @objc func reloadDataInGridFlowLayout() {
        gridFlowLayout.collectionView?.reloadData()
    }
}


