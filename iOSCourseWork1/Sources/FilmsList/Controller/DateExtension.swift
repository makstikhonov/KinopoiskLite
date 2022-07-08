//
//  DateExtension.swift
//  iOSCourseWork1
//
//  Created by max on 21.02.2022.
//  Copyright © 2022 Ildar Zalyalov. All rights reserved.
//

import Foundation

extension Date {
    /// Function counts the number of days from the entered date to today
    /// - Parameters
    ///   - date: date
    /// - Returns: number of days
    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([component], from: self, to: date).value(for: component)
    }
}
