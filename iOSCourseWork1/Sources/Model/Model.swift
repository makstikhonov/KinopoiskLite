//
//  Model.swift
//  iOSCourseWork1
//
//  Created by max on 21.02.2022.
//  Copyright © 2022 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

struct FilmData: Codable {
    var imageName: Data
    var description: String?
    var date: Date?
    var rate: Int?
    var pathToVideo: String?
    
    func getImage(from data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}

struct User: Codable {
    var login: String?
    var password: String?
    var name: String?
    var surname: String?
    var isUserLogged: Bool?
    var filmData: [FilmData]?
}

struct Users: Codable {
    var users: [User]?
}

extension UIImage {
    var jpeg: Data? { jpegData(compressionQuality: 0.8) }
}

