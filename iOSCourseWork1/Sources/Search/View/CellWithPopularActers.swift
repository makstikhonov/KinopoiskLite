//
//  CellOne.swift
//  UICollectonExample
//
//  Created by max on 14.01.2022.
//

import UIKit

class CellWithPopularActers: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: table setup
    func setup() {
        contentView.addSubview(collectionView)
        collectionView.edgeTo(contentView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: Metrics.cellName)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Metrics.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Metrics.cellName, for: indexPath) as! IconCell
        cell.imageView.image = UIImage(named: "1\(indexPath.row)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: frame.height - Metrics.collectionViewItemWidth, height: frame.height - Metrics.collectionViewItemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return Metrics.collectionViewSectionInsets
    }
    //MARK: uicollectionview cell
    private class IconCell: UICollectionViewCell {
        
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .center
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = Metrics.imageInCollectionViewCornerRadius
            return imageView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setup() {
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: Metrics.imageInCollectionViewWidthOffset).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: Metrics.imageInCollectionViewHeightOffset).isActive = true
        }
    }
    
    enum Metrics {
        static let cellName: String = "cell"
        static let numberOfItemsInSection: Int = 6
        static let collectionViewSectionInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        static let collectionViewItemHeight: CGFloat = 20
        static let collectionViewItemWidth: CGFloat = 40
        static let imageInCollectionViewCornerRadius: CGFloat = 15
        static let imageInCollectionViewWidthOffset: CGFloat = 100
        static let imageInCollectionViewHeightOffset: CGFloat = 130
    }
}


