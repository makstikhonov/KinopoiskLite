//
//  DateFormatterExtension.swift
//  iOSCourseWork1
//
//  Created by max on 04.03.2022.
//  Copyright © 2022 Ildar Zalyalov. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    /// the function translates the date from string into the Date
    /// - Parameter date: date in string presentaion
    /// - Returns: date in Date format
    func stringToDate(date: String) -> Date{
        self.dateFormat = "dd.MM.yy"
        return (self.date(from: date) ?? Date())
    }
    
    /// the function translates the date from Date  into the string
    /// - Parameter date: date in Date format
    /// - Returns: date in string presentaion
    func dateToString(date: Date) -> String{
        self.dateFormat = "dd.MM.yy"
        return (self.string(from: date))
    }
}
