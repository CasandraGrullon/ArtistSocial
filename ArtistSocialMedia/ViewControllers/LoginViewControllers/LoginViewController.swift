//
//  LoginViewController.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 11/3/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //textfields
    private func configureTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    //Login
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                DispatchQueue.main.async {
                    //self.showAlert(title: "Missing Fields", message: "Email and Password are required")
                }
                return
        }
        continueLoginFlow(email: email, password: password)
    }
    private func continueLoginFlow(email: String, password: String) {
        AuthenticationSession.shared.signExisitingUser(email: email, password: password) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    //self?.showAlert(title: "Login Error", message: "Unable to login at this time error: \(error.localizedDescription)")
                }
            case .success:
                DispatchQueue.main.async {
                    self?.navigateToMainApp()
                }
            }
        }
    }
    private func navigateToMainApp() {
        UIViewController.showViewController(storyboardName: "Main", viewcontrollerID: "MainAppTabBar")
    }
    //Third Party Sign In
    @IBAction func googleButtonPressed(_ sender: UIButton) {
    }
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
    }
    @IBAction func twitterButtonPressed(_ sender: UIButton) {
    }
    //Sign Up
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
