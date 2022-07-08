//
//  DataManager.swift
//  iOSCourseWork1
//
//  Created by max on 04.03.2022.
//  Copyright © 2022 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    private var getUsersDataOperationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    private var saveUsersDataOperationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    private var searchUsersDataOperationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()

    private let usersDefaults = UserDefaults.standard
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    
    /// Function retrieves the data of all stored users
    /// - Parameters:
    ///   - Key: userDefaults key
    ///   - qos: quality of service in Operation Queue
    ///   - completion: returned users data
    func obtainUsersData(Key: String = UserDefaultsKeys.usersKey,  completion: @escaping (Users) -> Void) {
        
        var defaultUsers = Users()
        
        let  getUsersDataOperation = BlockOperation {[weak self] in
            if let usersData = self?.usersDefaults.data(forKey: Key) {
                guard let users = try? self?.jsonDecoder.decode(Users.self, from: usersData) else { return }
                defaultUsers = users
            }
        }
        
        let completionOperation = BlockOperation {
            DispatchQueue.main.async {
                completion(defaultUsers)
            }
        }
        
        completionOperation.addDependency(getUsersDataOperation)
        getUsersDataOperationQueue.addOperations([getUsersDataOperation, completionOperation], waitUntilFinished: false)
    }
    
    func obtainFilteredResults(Key: String = UserDefaultsKeys.usersKey, searchText: String, completion: @escaping ([FilmData]) -> Void) {
        
        var loggedUser = User()
        var defaultUsers = Users()
        var filteredModels: [FilmData] = []
        
        let  getUsersDataOperation = BlockOperation {[weak self] in
            if let usersData = self?.usersDefaults.data(forKey: Key) {
                guard let users = try? self?.jsonDecoder.decode(Users.self, from: usersData) else { return }
                defaultUsers = users
            }
        }
        
        let loggedUserFindOperation = BlockOperation {
            for user in defaultUsers.users ?? [User()]{
                if user.isUserLogged == true {
                    loggedUser = user
                }
            }
        }
        
        let filterContentOperation = BlockOperation{
            guard let models = loggedUser.filmData else {return}
            filteredModels = models.filter ({ (data: FilmData) -> Bool in
                guard let stringMatch = data.description?.lowercased().contains(searchText.lowercased())
                else {return false}
                
                return stringMatch
            })
            DispatchQueue.main.async {
                completion(filteredModels)
            }
        }
        searchUsersDataOperationQueue.addOperations([getUsersDataOperation, loggedUserFindOperation, filterContentOperation], waitUntilFinished: false)
    }
    
    /// Function saves the data of all users
    /// - Parameters:
    ///   - Key: userDefaults key
    ///   - qos: quality of service in Operation Queue
    ///   - completion: returned users data
    func saveUsersData(Key: String = UserDefaultsKeys.usersKey, users: Users) {
        
        let saveUsersDataOperation = BlockOperation {
            do {
                let usersData = try
                self.jsonEncoder.encode(users)
                self.usersDefaults.set(usersData, forKey: Key)
            } catch let error {
                print("Error \(error)")
            }
        }
        saveUsersDataOperationQueue.addOperation(saveUsersDataOperation)
    }
    
    /// Function returns logged user,
    /// - Parameter completion: returned user
    func obtainLoggedUserData(Key: String = UserDefaultsKeys.usersKey,  completion: @escaping (User) -> Void) {
        
        var result = User()
        var defaultUsers = Users()
        
        let  getUsersDataOperation = BlockOperation {[weak self] in
            if let usersData = self?.usersDefaults.data(forKey: Key) {
                guard let users = try? self?.jsonDecoder.decode(Users.self, from: usersData) else { return }
                defaultUsers = users
            }
        }
        
        let checkIfLOggedUserExistOperation = BlockOperation {
            for user in defaultUsers.users ?? [User()]{
                if user.isUserLogged == true {
                    result = user
                }
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        checkIfLOggedUserExistOperation.addDependency(getUsersDataOperation)
        getUsersDataOperationQueue.addOperations([getUsersDataOperation, checkIfLOggedUserExistOperation], waitUntilFinished: false)
    }
    
    /// Function checks is there is a user with this username and password
    /// - Parameters:
    ///   - login: user login
    ///   - pass: user password
    ///   - completion: returnes users data
    func loginVerification(Key: String = UserDefaultsKeys.usersKey, login: String, pass: String, completion: @escaping (Result<User, Error>) -> Void) {
        var defaultUsers = Users()
        var loggedUser = User()
        
        let  getUsersDataOperation = BlockOperation {[weak self] in
            if let usersData = self?.usersDefaults.data(forKey: Key) {
                guard let users = try? self?.jsonDecoder.decode(Users.self, from: usersData) else { return }
                defaultUsers = users
            }
        }
        
        let checkPassAndLoginOperation = BlockOperation {
            guard let dUsers = defaultUsers.users else {return}
            for (index,user) in dUsers.enumerated(){
                if pass == user.password && login == user.login {
                    loggedUser = dUsers[index]
                    loggedUser.isUserLogged = true
                    DispatchQueue.main.async {
                        completion(.success(loggedUser))
                    }
                    return
                }
            }
            DispatchQueue.main.async {
                completion(.failure(DataMangerErrors.loginOrPassError))
            }
        }
        checkPassAndLoginOperation.addDependency(getUsersDataOperation)
        getUsersDataOperationQueue.addOperations([getUsersDataOperation, checkPassAndLoginOperation], waitUntilFinished: false)
    }
    
    
    func saveLoggedUserData(Key: String = UserDefaultsKeys.usersKey, userToSave: User, completion: @escaping () -> Void) {

        var defaultUsers = Users()
        
        let  getUsersDataOperation = BlockOperation {[weak self] in
            if let usersData = self?.usersDefaults.data(forKey: Key) {
                guard let users = try? self?.jsonDecoder.decode(Users.self, from: usersData) else { return }
                defaultUsers = users
            }
        }
        
        let checkLoginOperation = BlockOperation {
            guard let users = defaultUsers.users else {return}
            for (index, userToCompare) in users.enumerated(){
                if userToCompare.login! == userToSave.login {
                    defaultUsers.users![index] = userToSave
                    print(defaultUsers)
                }
            }
        }
        
        let saveUsersDataOperation = BlockOperation {
            do {
                let usersData = try
                self.jsonEncoder.encode(defaultUsers)
                self.usersDefaults.set(usersData, forKey: Key)
            } catch let error {
                print("Error \(error)")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
        saveUsersDataOperationQueue.addOperations([getUsersDataOperation, checkLoginOperation, saveUsersDataOperation], waitUntilFinished: false)
        
    }
    
    /// Function returnes data set for 2 default user
    /// - Returns: 2 users
    func usersDataInitialization() -> Users {
        var defaultUsers = Users()
        let model = FilmDataManager()
        
        defaultUsers.users = [
            User(login: "User1", password: "pass1",name: "Иван", surname: "Петров", isUserLogged: false, filmData: model.createModelsForUser1()),
            User(login: "User2", password: "pass2",name: "Петр", surname: "Иванов", isUserLogged: false, filmData: model.createModelsForUser2())
        ]
        return defaultUsers
    }
}

enum DataMangerErrors: Error {
    case loginOrPassError
}
extension DataMangerErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .loginOrPassError:
            return NSLocalizedString("Неправильный пароль \nили нет такого пользователя", comment: "Login error")
        }
    }
}

enum UserDefaultsKeys {
    static let usersKey: String = "Users"
}
