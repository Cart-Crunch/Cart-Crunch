//
//  SignUpViewController.swift
//  Cart Crunch
//
//  Created by Gabe Jones on 4/20/23.
//

import UIKit

class SignUpViewController: UIViewController {

    //MARK: - UIComponents
    let emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor(red: 52/255, green: 76/255, blue: 93/255, alpha: 1).cgColor
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
       
    let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor(red: 52/255, green: 76/255, blue: 93/255, alpha: 1).cgColor
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
       
    let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 249/255, green: 118/255, blue: 82/255, alpha: 1)
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
 //           button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
   
    let screenTitle: UILabel = {
        let screenTitle = UILabel()
        screenTitle.text = "Sign Up"
        screenTitle.font = UIFont(name: "Arial-BoldMT", size: 35)
        screenTitle.textAlignment = .center
        screenTitle.textColor = UIColor(red: 52/255, green: 76/255, blue: 93/255, alpha: 1)
        return screenTitle
    }()
    
    //MARK: - setupButtonTargets
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
    }
    
    //MARK: - setupUI
    private func setupUI() {
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
        view.addSubview(screenTitle)
       
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            screenTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            screenTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),



            emailField.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 50),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emailField.heightAnchor.constraint(equalToConstant: 45),
           
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            passwordField.heightAnchor.constraint(equalToConstant: 45),
           
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -75),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
           
        ])
    }
    
    //MARK: - Button functions
    
}
