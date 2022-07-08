//
//  LoginViewController.swift
//  iOSCourseWork1
//
//  Created by max on 25.03.2022.
//  Copyright © 2022 Ildar Zalyalov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak private var loginTF: UITextField!
    @IBOutlet weak private var passwordTF: UITextField!
    @IBOutlet weak private var loginButton: UIButton!
    
    private let dataManager = DataManager()
    var tabBarVC: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: action when login button is pressed
    /// When button is pressed, function checks if the user exists and password matches
    @IBAction func loginPressed(_ sender: Any) {
        
        guard let loginText = loginTF.text, !loginText.isEmpty else {
            return }
        guard let passwordText = passwordTF.text, !passwordText.isEmpty else {
            return }
        
        dataManager.loginVerification(login: loginText, pass: passwordText) {[weak self, unowned tabBarVC] result in
            switch result {
            case .success(let user):
                self?.dataManager.saveLoggedUserData(userToSave: user) {
                    self?.present(tabBarVC!, animated: true, completion: nil)
                }
            case .failure(let error):
                self?.alertError(message: error.localizedDescription)
            }
        }
    }
    /// Function open alert message
    /// - Parameter message: message to show
    func alertError(message: String) {
        let alertController = UIAlertController(title: AlertTitles.errorMessage, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: AlertTitles.okButtonTitle, style: .default, handler: nil)
        
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
}
extension LoginViewController {
    enum AlertTitles {
        static let errorMessage: String = "Ошибка"
        static let okButtonTitle: String = "Ok"
    }
}
