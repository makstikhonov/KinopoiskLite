//
//  StoryBoardFactory.swift
//  iOSCourseWork1
//
//  Created by max on 19.04.2022.
//  Copyright © 2022 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

class StoryBoardFactory {
    /// Function obtains viewcontroller from the storyboard
    /// - Parameters:
    ///   - storyboardName: storyboardname
    ///   - identifier: storyboard identifier
    /// - Returns: viewcontroller
    func obtainScreenController (storyboardName: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let mainController = storyboard.instantiateViewController(withIdentifier: identifier)
        return mainController
    }
}

enum StoryBoardName {
    case loginStoryBoard
    case moviesStoryBoard
    var storyBoardIdentifier: String {
        switch self {
        case .loginStoryBoard:
            return "loginViewController"
        case .moviesStoryBoard:
            return "tableController"
        }
    }
    var storyBoardTitle: String {
        switch self {
        case .loginStoryBoard:
            return "Login"
        case .moviesStoryBoard:
            return "Main"
        }
    }
}

