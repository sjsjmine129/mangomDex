//
//  StickerDetailViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 3/16/24.
//

import UIKit

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
    
    private let index: Int
    private var stickerViewModel : StickerViewModel
    var stickers : [Sticker]
    
    init(viewModel: StickerViewModel, index: Int, stickers: [Sticker]) {
        self.stickerViewModel = viewModel
        self.index = index
        self.stickers = stickers
        print("hello: \(self.index) ")
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .magClothes
        //        setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        
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


// MARK: - set data of grid
extension StickerDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sticker = self.stickers[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerDetailCollectionViewCell.id, for: indexPath) as! StickerDetailCollectionViewCell
        
        cell.detailCellConfigure(with: sticker)
        
        return cell
    }
}

extension StickerDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
