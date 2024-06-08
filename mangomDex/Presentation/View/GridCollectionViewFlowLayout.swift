//
//  GridCollectionViewFlowLayout.swift
//  mangomDex
//
//  Created by 엄승주 on 3/11/24.
//

import UIKit

class GridCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var ratioHeightToWidth = 1.3141592
    var numberOfColumns = 4
    var cellSpacing = 0.0 {
        didSet {
            self.minimumLineSpacing = self.cellSpacing
            self.minimumInteritemSpacing = self.cellSpacing
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override init() {
        super.init()
        self.scrollDirection = .vertical
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
