//
//  CreateAccountUIViewController.swift
//  BuySellAppIOS
//
//  Created by Michael Lee Baldrick on 19/01/2018.
//  Copyright © 2018 Michael Lee Baldrick. All rights reserved.
//

import UIKit

class CreateAccountUIViewController: UIViewController, SubmitAccountDetailsDelegate, ViewModelDidUpdateDelegate {

    
    private var createAccountView: CreateAccountUIView!
    private var viewModel: CreateAccountViewModel!
    var delegate: LoginUIViewControllerDelegate!
    
    func initialize() {
        createAccountView = CreateAccountUIView(frame: CGRect.zero)
        createAccountView.delegate = self
        
        self.viewModel = CreateAccountViewModel(firstName: "", lastName: "", dateOfBirth: Date(), email: "", username: "", password: "", confPassword: "", viewModelDidUpdateDelegate: self)
        
        self.view.addSubview(createAccountView)
        self.title = "Create Account"

        setupConstraints()
    }
    
    
    func setupConstraints() {
        let margins = view.layoutMarginsGuide
    
        createAccountView.translatesAutoresizingMaskIntoConstraints = false
        createAccountView.topAnchor.constraint( equalTo: margins.topAnchor, constant: 50).isActive  = true
        createAccountView.leftAnchor.constraint( equalTo: margins.leftAnchor).isActive  = true
        createAccountView.rightAnchor.constraint( equalTo: margins.rightAnchor).isActive  = true
        createAccountView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
    
    func submitAccountDetails(firstName: String, lastName: String, username: String, password: String, confPassword: String, dateOfBirth: Date, email: String) {
        setViewModelProperties(firstName: firstName, lastName: lastName, username: username, password: password, confPassword: confPassword, dateOfBirth: dateOfBirth, email: email)
        if (!viewModel.hasValidationError) {
            delegate.attemptedCreateAccount(firstName: firstName, lastName: lastName, username: username, password: password, confPassword: confPassword, dateOfBirth: dateOfBirth, email: email) {
                () in
                print("failed to create account")
            }
        }
    }
    
    func setViewModelProperties(firstName: String, lastName: String, username: String, password: String, confPassword: String, dateOfBirth: Date, email: String) {
        viewModel.firstName = firstName
        viewModel.lastName = lastName
        viewModel.username = username
        viewModel.password = password
        viewModel.confPassword = confPassword
        viewModel.dateOfBirth = dateOfBirth
        viewModel.email = email
    }
    
    func viewModelDidUpdate(key: String, value: Any) {
        print("View model variable changed: \(key) \(value)")
        switch key {
            case "hasFirstNameValidationError":
                self.createAccountView.firstNameValidationLbl.isHidden = !(value as! Bool)
            case "hasLastNameValidationError":
                self.createAccountView.lastNameValidationLbl.isHidden = !(value as! Bool)
            case "hasDateOfBirthValidationError":
                self.createAccountView.dateOfBirthValidationLbl.isHidden = !(value as! Bool)
            case "hasEmailValidationError":
                self.createAccountView.emailValidationLbl.isHidden = !(value as! Bool)
            case "hasUsernameValidationError":
                self.createAccountView.usernameValidationLbl.isHidden = !(value as! Bool)
            case "hasPasswordValidationError":
                self.createAccountView.passwordValidationLbl.isHidden = !(value as! Bool)
            case "hasConfirmPasswordValidationError":
                self.createAccountView.confPasswordValidationLbl.isHidden = !(value as! Bool)
            case "hasError":
                self.createAccountView.errorLbl.isHidden = !(value as! Bool)
            default:
                print("No action required")
        }
    
    }
    
}
