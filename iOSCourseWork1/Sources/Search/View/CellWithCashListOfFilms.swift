//
//  CellOne.swift
//  UICollectonExample
//
//  Created by max on 14.01.2022.
//

import UIKit

class CellWithCashListOfFilms: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    let chevronView: UIImageView = {
        let image = UIImage(systemName: Metrics.chevronViewImageName)
        let icon = UIImageView(image: image)
        icon.contentMode = .center
        icon.tintColor = .systemGray
        return icon
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Metrics.titleLabelFontSize)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetup() {
        
        contentView.addSubview(cellView)
        cellView.edgeTo(contentView)
        cellView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo:  cellView.leftAnchor, constant: Metrics.titleLabelLeftMargin).isActive = true
        
        cellView.addSubview(chevronView)
        chevronView.translatesAutoresizingMaskIntoConstraints = false
        chevronView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        chevronView.leftAnchor.constraint(equalTo:  cellView.rightAnchor, constant: Metrics.chevronViewRightMargin).isActive = true
    }
    
    enum Metrics {
        static let titleLabelFontSize: CGFloat = 16
        static let chevronViewImageName: String = "chevron.right"
        static let titleLabelLeftMargin: CGFloat = 20
        static let chevronViewRightMargin: CGFloat = -30
    }
}


