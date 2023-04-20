//
//  SignUpViewController.swift
//  Cart Crunch
//
//  Created by Gabe Jones on 4/20/23.
//

import UIKit
import ParseSwift

class SignUpViewController: UIViewController {
  
    //MARK: - UIComponents
   let usernameField: UITextField = {
       let textField = UITextField()
       textField.placeholder = "Username"
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


    private func addButtonTargets() {
        signUpButton.addTarget(self, action: #selector(onSignUpButtonTapped), for: .touchUpInside)
    }

    //MARK: - viewDidLoad
   override func viewDidLoad() {
       super.viewDidLoad()
       setupUI()
       addButtonTargets()
       view.backgroundColor = .white
   }
  
    //MARK: - setupUI
   private func setupUI() {
       view.addSubview(usernameField)
       view.addSubview(passwordField)
       view.addSubview(emailField)
       view.addSubview(signUpButton)
       view.addSubview(screenTitle)
      
       usernameField.translatesAutoresizingMaskIntoConstraints = false
       passwordField.translatesAutoresizingMaskIntoConstraints = false
       signUpButton.translatesAutoresizingMaskIntoConstraints = false
       screenTitle.translatesAutoresizingMaskIntoConstraints = false
       emailField.translatesAutoresizingMaskIntoConstraints = false
      
       NSLayoutConstraint.activate([
           screenTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
           screenTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

           usernameField.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 50),
           usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
           usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
           usernameField.heightAnchor.constraint(equalToConstant: 45),
          
           emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
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
    
    //MARK: - signUpFunctions
    @objc private func onSignUpButtonTapped() {
        //make sure that all fields are non-nil
        guard let username = usernameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !username.isEmpty,
              !email.isEmpty,
              !password.isEmpty else {
            //show missing fields alert here
            return
        }
        
        //Parse user sign up
        var newUser = User()
        newUser.email = email
        newUser.username = username
        newUser.password = password
        
        newUser.signup {[weak self] result in
            switch result {
            case .success(let user):
                print("Successfully signed up user \(user)")
                
                //post a notification that the user has succesfully signed up
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
                
                
            case .failure(let error):
                //failure to sign up
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Sign Up", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
        
    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Oops...", message: "We need all of the fields filled out in order to sign you up.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}


