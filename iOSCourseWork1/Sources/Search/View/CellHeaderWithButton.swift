//
//  CellHeaderWithButton.swift
//  iOSCourseWork1
//
//  Created by max on 27.03.2022.
//  Copyright © 2022 Ildar Zalyalov. All rights reserved.
//

import UIKit

class CellHeaderWithButton: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Metrics.titleLabelFontSize)
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle(Metrics.titleLabelText, for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Metrics.buttonLabelFontSize)
        button.backgroundColor = UIColor.clear
        return button
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
        
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.rightAnchor.constraint(equalTo:  self.rightAnchor, constant: Metrics.buttonRightMargin).isActive = true
    }
    
    enum Metrics {
        static let titleLabelFontSize: CGFloat = 20
        static let buttonLabelFontSize: CGFloat = 14
        static let titleLabelLeftMargin: CGFloat = 10
        static let buttonRightMargin: CGFloat = -30
        static let titleLabelText: String = "Все"
    }
}
