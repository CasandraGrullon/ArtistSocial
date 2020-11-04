//
//  SignUpViewController.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 11/3/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureNavBar()
    }
    //textfields
    private func configureTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    //navigation Controller
    private func configureNavBar() {
    
    }
    //Sign Up
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let confirm = confirmPasswordTextField.text, !confirm.isEmpty,
            confirm == password else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Missing Fields", message: "Email and Password are required")
                }
                return
        }
        
        AuthenticationSession.shared.createNewUser(email: email, password: password) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Sign Up Error", message: "Unable to sign up at this time error: \(error.localizedDescription)")
                }
            case .success(let authDataResult):
                DispatchQueue.main.async {
                    self?.createUser(authDataResult: authDataResult)
                }
            }
        }
    }
    private func createUser(authDataResult: AuthDataResult) {
        DatabaseService.shared.createAppUser(authDataResult: authDataResult) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("unable to create user on database error: \(error.localizedDescription)")
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
    //Third Party Sign Up
    @IBAction func googleButtonPressed(_ sender: UIButton) {
    }
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
    }
    @IBAction func twitterButtonPressed(_ sender: UIButton) {
    }
}
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
