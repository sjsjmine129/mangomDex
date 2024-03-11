//
//  ViewController.swift
//  mangomDex
//
//  Created by 엄승주 on 2/27/24.
//

import UIKit

class StickerViewController: UIViewController {
    
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
    
    private lazy var stickerViewModel = StickerViewModel()
    
    // MARK - LifeCycle
    override func loadView() {
        super.loadView()
        setNavigationBar()
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
        ])
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
}


// MARK: - set data of grid
extension StickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.stickerViewModel.stickers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sticker = stickerViewModel.stickers[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCollectionViewCell.id, for: indexPath) as! StickerCollectionViewCell
        
        cell.cellConfigure(with: sticker)
        
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
        
        let barButton = UIBarButtonItem(customView: title)
        
        navigationItem.leftBarButtonItem = barButton
        
        self.navigationController?.navigationBar.frame.size.height = 50
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.barTintColor = .magClothes
        
    }
}
