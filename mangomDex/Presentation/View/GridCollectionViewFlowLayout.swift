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
    
    private var pinchGestureRecognizer: UIPinchGestureRecognizer!
    private var initialPinchScale: CGFloat = 1.0
    private var columns: Int = 4
    
    override func prepare() {
        super.prepare()
        setupPinchGestureRecognizer()
    }
    
    private func setupPinchGestureRecognizer() {
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        collectionView?.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    @objc private func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard collectionView != nil else { return }
        switch gestureRecognizer.state {
        case .began:
            initialPinchScale = gestureRecognizer.scale
            columns = numberOfColumns
        case .changed:
            let scale = gestureRecognizer.scale
            if scale > 1{
                let roundedDeltaScale = Int(round(scale))
                let temp = columns - roundedDeltaScale
                if(temp > 1 && temp < 9 && temp != columns){
                    numberOfColumns = temp
                    self.collectionView?.reloadData()
                }
            }
            else{
                let roundedDeltaScale = Int(round(1/scale))
                let temp = columns + roundedDeltaScale
                if(temp > 1 && temp < 9 && temp != columns){
                    numberOfColumns = temp
                    self.collectionView?.reloadData()
                }
            }

        default:
            break
        }
    }
    
    private func adjustZoomScale(_ scale: CGFloat, at pinchLocation: CGPoint) {
        guard let collectionView = collectionView else { return }
        
        let zoomCenter = collectionView.convert(pinchLocation, to: collectionView.superview)
        
        for attributes in layoutAttributesForElements(in: collectionView.bounds)! {
            let distance = abs(zoomCenter.x - attributes.center.x)
            let scale = 1 - ((1 - scale) * distance / collectionView.bounds.width)
            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
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
