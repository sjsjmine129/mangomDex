//
//  ViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit

class StickerViewController: UIViewController {
    private lazy var stickerViewModel = StickerViewModel()
    
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
        
        setNavigationBar()
        setBindings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        pinchGestureRecognizer.delegate = self
        collectionView.addGestureRecognizer(pinchGestureRecognizer)
        
        self.view.backgroundColor = UIColor(resource: .magClothes)
        self.view.addSubview(collectionView)
        self.view.addSubview(stNoSticker)
    
        btnDropdown.ddFilter.selectionAction = { [unowned self] (index: Int, item: String) in
            stickerViewModel.changeFilter(filtertype: item)
        }
        
        btnDropdown.ddFilter.cancelAction = { [weak self] in
            self?.stickerViewModel.setDropDownImage(imgName: "chevron.down")
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
        let stickerNum =  stickerViewModel.filteredStickers.count
        
        // show no sticker image
        if stickerNum == 0 {
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
        
        return stickerNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sticker = stickerViewModel.filteredStickers[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCollectionViewCell.id, for: indexPath) as! StickerCollectionViewCell
        
        cell.cellConfigure(delegate: self, viewModel: stickerViewModel)
        stickerViewModel.setGridCellUIData(cell: cell, sticker: sticker, index: indexPath.row, colunms: self.gridFlowLayout.numberOfColumns)
        
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

// MARK: - objc
extension StickerViewController{
    // show DropDown
    @objc func showDropdown(_ sender: UIButton){
        BtnAction.btnActionSize(button: sender)
        btnDropdown.ddFilter.show()
        stickerViewModel.setDropDownImage(imgName: "chevron.up")
    }
    
    //reload grid
    @objc func reloadDataInGridFlowLayout() {
        gridFlowLayout.collectionView?.reloadData()
        stickerViewModel.setNumberString()
    }
    
    // reset sticker numberData
    @objc func resetStickerNumberData(){
        stickerViewModel.resetNumberToZero()
        gridFlowLayout.collectionView?.reloadData()
        stickerViewModel.setNumberString()
    }
    
    @objc func changeCollectionNum(){
        stickerViewModel.setNumberString()
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
            let nextPage = StickerDetailViewController(viewModel: self.stickerViewModel, index: index ?? 0, stickers: self.stickerViewModel.filteredStickers)
            navigationController.pushViewController(nextPage, animated: true)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension StickerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


// MARK: - set bindings
extension StickerViewController{
    func setBindings() {
        stickerViewModel.dropdownImage.bind { [weak self] imageName in
            self?.btnDropdown.imgVwDropDown.image = UIImage(systemName: imageName)?.withTintColor(.textBlack, renderingMode: .alwaysOriginal)
        }
        
        stickerViewModel.filterMode.bind{ [weak self] mode in
            self?.btnDropdown.lblDropdownTitle.text = mode
            self?.gridFlowLayout.collectionView?.reloadData()
        }
        
        stickerViewModel.numberString.bind{ [weak self] text in
            self?.vwTitle.lblStickerNum.text = text
        }
    }
}
