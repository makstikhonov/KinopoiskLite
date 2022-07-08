//
//  SceneDelegate.swift
//  iOSCourseWork1
//
//  Created by Ильдар Залялов on 24.08.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let dataManager = DataManager()
    private var tabBarVC: UITabBarController!
    private var loggedUser = User()
    private let storyBoardFactory = StoryBoardFactory()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        //MARK: controllers intialization
        let filmsViewController = storyBoardFactory.obtainScreenController(storyboardName: StoryBoardName.moviesStoryBoard.storyBoardTitle, identifier: StoryBoardName.moviesStoryBoard.storyBoardIdentifier) as! ListOfFilmsViewController
        let filmsNavigationController = UINavigationController(rootViewController: filmsViewController)
        filmsViewController.title = ViewControllersTitles.filmsViewControllerTitle
        
        let searchViewController = SearchViewController()
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchNavigationController.title = ViewControllersTitles.searchViewControllerTitle
        
        tabBarVC = tabBarInitilization([filmsNavigationController, searchNavigationController])
        
        dataManager.obtainUsersData() { [weak self] (data) in
            var defaultUsers = Users()
            defaultUsers = data
            
            guard let strongSelf = self else { return }
            
            //MARK: iniatilization of users data
            if defaultUsers.users == nil {
                defaultUsers = strongSelf.dataManager.usersDataInitialization()
                strongSelf.dataManager.saveUsersData(users: defaultUsers)
            }
            
            //MARK: check if some user is already logged
            strongSelf.dataManager.obtainLoggedUserData {[weak self] (user) in
                self?.loggedUser = user
                
                if strongSelf.loggedUser.isUserLogged != true {
                    strongSelf.window?.rootViewController = strongSelf.loginViewControllerInitializaion()
                }
                else {
                    strongSelf.window?.rootViewController = strongSelf.tabBarVC
                }
                strongSelf.window?.makeKeyAndVisible()
            }
        }
    }
    
    func loginViewControllerInitializaion() -> LoginViewController{
        let loginViewController = storyBoardFactory.obtainScreenController(storyboardName: StoryBoardName.loginStoryBoard.storyBoardTitle, identifier: StoryBoardName.loginStoryBoard.storyBoardIdentifier) as! LoginViewController
        loginViewController.title = ViewControllersTitles.loginViewControllerTitle
        loginViewController.tabBarVC = tabBarVC
        
        return loginViewController
    }
    
    func tabBarInitilization(_ viewControllers: [UIViewController]) -> UITabBarController {
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers(viewControllers, animated: true)
        tabBarVC.tabBar.items?[0].image = UIImage(systemName: TabBarIcons.filmsIcon)
        tabBarVC.tabBar.items?[1].image = UIImage(systemName: TabBarIcons.lensIcons)
        
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.modalTransitionStyle = .crossDissolve
        
        return tabBarVC
    }
}
extension SceneDelegate {
    enum TabBarIcons {
        static let filmsIcon: String = "list.and.film"
        static let lensIcons: String = "magnifyingglass"
    }
}

enum ViewControllersTitles {
    static let filmsViewControllerTitle: String = "Фильмы"
    static let searchViewControllerTitle: String = "Поиск"
    static let loginViewControllerTitle: String = "Логин"
}

enum StoryBoardTitles {
    static let filmsStoryBoardTitle: String = "Main"
    static let loginStoryBoardTitle: String = "Login"
}


