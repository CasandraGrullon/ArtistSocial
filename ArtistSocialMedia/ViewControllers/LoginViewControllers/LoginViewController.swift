//
//  LoginViewController.swift
//  ArtistSocialMedia
//
//  Created by casandra grullon on 11/3/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import FirebaseAuth

private enum AccountState {
    case newUser
    case existingUser
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordPrompt: UILabel!
    
    @IBOutlet weak var thirdPartySignUpPrompt: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var signUpPrompt: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    //Manipulatable constraints
    @IBOutlet weak var textfieldStackHeight: NSLayoutConstraint!
    @IBOutlet weak var logoImageTopAnchor: NSLayoutConstraint!
    
    private var accountState: AccountState = .existingUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginUI()
        configureTextFields()
        configureNavBar()
    }
    //textfields
    private func configureTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    //nav bar
    private func configureNavBar() {
        navigationController?.isNavigationBarHidden = true
    }
    //Login
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            DispatchQueue.main.async {
                self.showAlert(title: "Missing Fields", message: "Email and Password are required")
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
                    self?.showAlert(title: "Login Error", message: "Unable to login at this time error: \(error.localizedDescription)")
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
    //TODO:- third party sign in methods
    //Third Party Sign In
    @IBAction func googleButtonPressed(_ sender: UIButton) {
    }
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
    }
    @IBAction func twitterButtonPressed(_ sender: UIButton) {
    }
    //Sign Up
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        accountState = accountState == .existingUser ? .newUser : .existingUser
        if accountState == .existingUser {
            loginUI()
        } else {
            signUpUI()
        }
    }
    private func loginUI() {
        pageLabel.text = "Welcome back!"
        thirdPartySignUpPrompt.text = "- or log in with -"
        loginButton.setTitle("Login", for: .normal)
        signUpPrompt.text = "Don't have an account?"
        signUpButton.setTitle("Sign Up", for: .normal)
        
        textfieldStackHeight.constant = 180 - (180 * 0.33)
        
        confirmPasswordPrompt.isHidden = true
        confirmPasswordTextField.isHidden = true
    }
    private func signUpUI() {
        pageLabel.text = "Create an account"
        thirdPartySignUpPrompt.text = "- or sign up with -"
        loginButton.setTitle("Create Account", for: .normal)
        signUpPrompt.text = "Already have an account?"
        signUpButton.setTitle("Log In", for: .normal)
        
        textfieldStackHeight.constant = 180
        
        confirmPasswordPrompt.isHidden = false
        confirmPasswordTextField.isHidden = false
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
