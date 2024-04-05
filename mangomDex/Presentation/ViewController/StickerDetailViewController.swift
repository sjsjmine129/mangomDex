//
//  StickerDetailViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 3/16/24.
//

import UIKit
import StoreKit

class StickerDetailViewController: UIViewController {
    
    // MARK: - UI
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.scrollDirection = .horizontal
        cv.backgroundColor = .magClothes
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(StickerDetailCollectionViewCell.self, forCellWithReuseIdentifier: "StickerDetailCollectionViewCell")
        return cv
    }()
    
    private lazy var swipeUpGestureRecognizer: UISwipeGestureRecognizer = {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUp(_:)))
        gestureRecognizer.direction = .up
        return gestureRecognizer
    }()
    
    
    private let index: Int
    private var stickerViewModel : StickerViewModel
    
    
    init(viewModel: StickerViewModel, index: Int) {
        self.stickerViewModel = viewModel
        self.index = index
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .magClothes
        setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if stickerViewModel.review{
            SKStoreReviewController.requestReview()
            stickerViewModel.review = false
        }
        
        
        self.view.addSubview(self.collectionView)
        self.view.addGestureRecognizer(swipeUpGestureRecognizer)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.layoutIfNeeded()
        self.collectionView.scrollToItem(at: IndexPath(item: self.index, section: 0), at: .centeredHorizontally, animated: false)
    }
    
}

// MARK: - navigationbar
extension StickerDetailViewController{
    //set navigation Bar UI of setting tab
    func setNavigationBar(){
        
        let title = UILabel()
        title.text = "띠부씰 상세"
        title.font = UIFont(name: "HUDdiu150", size: 25)
        title.textColor = UIColor(resource: .textBlack)
        
        if let image = UIImage(systemName: "chevron.left")?.withTintColor(.textBlack, renderingMode: .alwaysOriginal) {
            let customButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(leftButtonTapped))
            navigationItem.leftBarButtonItem = customButton
        }
        
        navigationItem.titleView = title
        
        self.navigationController?.navigationBar.frame.size.height = 50
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.barTintColor = .magClothes
    }
}


// MARK: - set data of grid
extension StickerDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stickerViewModel.filteredStickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerDetailCollectionViewCell.id, for: indexPath) as! StickerDetailCollectionViewCell
        
        cell.detailCellConfigure(viewModel: stickerViewModel)
        stickerViewModel.setDetailCellUIData(cell: cell, index: indexPath.row)
        
        return cell
    }
}

extension StickerDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

// MARK: - objc
extension StickerDetailViewController{
    @objc func leftButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleSwipeUp(_ gestureRecognizer: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}
