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
    var container: NSPersistentContainer!
    private lazy var stickerViewModel = StickerViewModel()
    lazy var stickers : [Sticker] = []
    private var pinchGestureRecognizer: UIPinchGestureRecognizer!
    private var initialPinchScale: CGFloat = 1.0
    private var columns: Int = 4
    
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
        view.clipsToBounds = true
        view.register(StickerCollectionViewCell.self, forCellWithReuseIdentifier: "StickerCollectionViewCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var vwTitle = StickerTitle()
    
    private lazy var btnDropdown = DropDownBtn()
    
    private lazy var stNoSticker = NoStickerStack()
    
    private lazy var vwOnboarding = OnboardingView()
    
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataInGridFlowLayout), name: NSNotification.Name(rawValue: "ReloadGridDataNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetStickerNumberData), name: NSNotification.Name(rawValue: "ResetStickerNumberData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeCollectionNum), name: NSNotification.Name(rawValue: "ChangeCollectionNum"), object: nil)
        
        btnDropdown.addTarget(self, action: #selector(showDropdown(_:)), for: .touchUpInside)
        
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
        
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        pinchGestureRecognizer.delegate = self
        collectionView.addGestureRecognizer(pinchGestureRecognizer)
        
        self.view.backgroundColor = UIColor(resource: .magClothes)
        
        self.view.addSubview(self.collectionView)
        self.view.addSubview(stNoSticker)
        
        
        vwTitle.lblStickerNum.text = stickerViewModel.getNumberString(stickers: self.stickers, condition: .all)
        
        btnDropdown.ddFilter.selectionAction = { [unowned self] (index: Int, item: String) in
            btnDropdown.lblDropdownTitle.text = item
            
            if let filter = StickerFilter(rawValue: item) {
                self.stickers = stickerViewModel.filteredStickers(condition: filter)
                vwTitle.lblStickerNum.text = stickerViewModel.getNumberString(stickers: self.stickers, condition: filter)
                
                gridFlowLayout.collectionView?.reloadData()
                
                self.changeImgVwDropDown(name: "chevron.down")
            } else {}
        }
        
        btnDropdown.ddFilter.cancelAction = { [weak self] in
            self?.changeImgVwDropDown(name: "chevron.down")
        }
        
        // show onboarding
        if stickerViewModel.onboarding{
            stickerViewModel.onboarding = false
            
            self.view.addSubview(vwOnboarding)
            vwOnboarding.btnClose.addTarget(self, action: #selector(closeOnBoarding(_:)), for: .touchUpInside)
            NSLayoutConstraint.activate([
                //vwOnboarding
                vwOnboarding.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                vwOnboarding.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                vwOnboarding.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
                vwOnboarding.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            ])
        }
        
        NSLayoutConstraint.activate([
            //collectionView
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
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
            stNoSticker.lblNoSticker.isHidden = false
            stNoSticker.imgVwNoSticker.isHidden = false
            
            if btnDropdown.lblDropdownTitle.text == "모은 띠부씰"{
                stNoSticker.imgVwNoSticker.image = UIImage(named: "falling.png")
                stNoSticker.lblNoSticker.text = "아직 수집한 띠부씰이 없어요."
                
            }else if btnDropdown.lblDropdownTitle.text == "없는 띠부씰"{
                stNoSticker.imgVwNoSticker.image = UIImage(named: "all.png")
                stNoSticker.lblNoSticker.text = "모든 띠부씰을 다 모았어요!"
            }
        }else{
            stNoSticker.lblNoSticker.isHidden = true
            stNoSticker.imgVwNoSticker.isHidden = true
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
        
        let leftBarBtn = UIBarButtonItem(customView: vwTitle)
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
            btnDropdown.imgVwDropDown.image = image
        }
    }
}

// MARK: - objc
extension StickerViewController{
    // show DropDown
    @objc func showDropdown(_ sender: UIButton){
        BtnAction.btnActionSize(button: sender)
        btnDropdown.ddFilter.show()
        changeImgVwDropDown(name: "chevron.up")
    }
    
    //reload grid
    @objc func reloadDataInGridFlowLayout() {
        gridFlowLayout.collectionView?.reloadData()
        setNumber()
    }
    
    // reset sticker numberData
    @objc func resetStickerNumberData(){
        stickerViewModel.resetNumberToZero()
        gridFlowLayout.collectionView?.reloadData()
        setNumber()
    }
    
    @objc func changeCollectionNum(){
        setNumber()
    }
    
    // close onBoarding
    @objc func closeOnBoarding(_ sender: UIButton){
        BtnAction.btnActionSize(button: sender)
        self.vwOnboarding.removeFromSuperview()
    }
    
    
    @objc private func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            initialPinchScale = gestureRecognizer.scale
            columns = gridFlowLayout.numberOfColumns
        case .changed:
            let scale = gestureRecognizer.scale
            if scale > 1{
                let roundedDeltaScale = Int(round(scale))
                let temp = columns - roundedDeltaScale
                if(temp > 1 && temp < 9 && temp != columns){
                    gridFlowLayout.numberOfColumns = temp
                    self.collectionView.reloadData()
                }
            }
            else{
                let roundedDeltaScale = Int(round(1/scale))
                let temp = columns + roundedDeltaScale
                if(temp > 1 && temp < 9 && temp != columns){
                    gridFlowLayout.numberOfColumns = temp
                    self.collectionView.reloadData()
                }
            }
            
        default:
            break
        }
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

extension StickerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func setNumber(){
        guard let item = btnDropdown.lblDropdownTitle.text else{return}
        if let filter = StickerFilter(rawValue: item) {
            vwTitle.lblStickerNum.text = stickerViewModel.getNumberString(stickers: self.stickers, condition: filter)
        } else {}
    }
}
