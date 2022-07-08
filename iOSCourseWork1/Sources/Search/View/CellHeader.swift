//
//  CellOne.swift
//  UICollectonExample
//
//  Created by max on 14.01.2022.
//

import UIKit

class CellHeader: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Metrics.titleLabelFontSize)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    func setup() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo:  self.leftAnchor, constant: Metrics.titleLabelLeftMargin).isActive = true
    }
    
    enum Metrics {
        static let titleLabelFontSize: CGFloat = 20
        static let titleLabelLeftMargin: CGFloat = 10
    }

}
