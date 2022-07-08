//
//  CustomTableViewCell.swift
//  iOSCourseWork1
//
//  Created by max on 21.02.2022.
//  Copyright © 2022 Ildar Zalyalov. All rights reserved.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func didPressCustomCellACtion(with rate: Int)
}

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak private var filmDescription: UILabel!
    @IBOutlet weak private var releaseDate: UILabel!
    @IBOutlet weak private var filmIcon: UIImageView!
    @IBOutlet weak private var rateButton: UIButton!
    
    private let dateFormatter = DateFormatter()
    weak var delegate: CustomCellDelegate!
    private var cellRating = 0
    
    /// Function configures table cell with data
    /// - Parameter data: data
    func configure(with data: FilmData) {
        
        guard let dataDate = data.date else {return}
        
        if let distance = dataDate.fullDistance(from: Date(), resultIn: .day) {
            switch distance {
            case 0:
                releaseDate.text = Metric.releaseDateToday
            case 1:
                releaseDate.text = Metric.releaseDateYesturday
            default:
                releaseDate.text = dateFormatter.dateToString(date: dataDate)
            }
        }
    
        filmDescription.text = data.description
        filmIcon.image = data.getImage(from: data.imageName)
        filmIcon.layer.cornerRadius = Metric.filmIconCornerRadius
        cellRating = data.rate ?? 0
    }
    
    @IBAction func rateButtonPress(_ sender: Any) {
        delegate.didPressCustomCellACtion(with: cellRating)
    }
}

extension CustomTableViewCell {
    enum Metric {
        static let releaseDateToday: String = "Сегодня"
        static let releaseDateYesturday: String = "Вчера"
        static let filmIconCornerRadius: CGFloat = 10
    }
}
