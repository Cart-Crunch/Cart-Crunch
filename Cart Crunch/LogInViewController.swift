//
//  LogInViewController.swift
//  Cart Crunch
//
//  Created by Gabe Jones on 4/20/23.
//

import UIKit

class LogInViewController: UIViewController {
  
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
      
   let logInButton: UIButton = {
       let button = UIButton()
       button.backgroundColor = UIColor(red: 249/255, green: 118/255, blue: 82/255, alpha: 1)
       button.setTitle("Log In", for: .normal)
       button.setTitleColor(UIColor.white, for: .normal)
       button.layer.cornerRadius = 5
       button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
       return button
   }()
      
   let screenTitle: UILabel = {
       let screenTitle = UILabel()
       screenTitle.text = "Log In"
       screenTitle.font = UIFont(name: "Arial-BoldMT", size: 35)
       screenTitle.textAlignment = .center
       screenTitle.textColor = UIColor(red: 52/255, green: 76/255, blue: 93/255, alpha: 1)
       return screenTitle
   }()
    
   //MARK: - add button targets
    @objc private func addButtonTargets() {
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
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
       view.addSubview(logInButton)
       view.addSubview(screenTitle)
      
       usernameField.translatesAutoresizingMaskIntoConstraints = false
       passwordField.translatesAutoresizingMaskIntoConstraints = false
       logInButton.translatesAutoresizingMaskIntoConstraints = false
       screenTitle.translatesAutoresizingMaskIntoConstraints = false
      
       NSLayoutConstraint.activate([
           screenTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
           screenTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

           usernameField.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 50),
           usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
           usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
           usernameField.heightAnchor.constraint(equalToConstant: 45),
          
           passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
           passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
           passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
           passwordField.heightAnchor.constraint(equalToConstant: 45),
          
           logInButton.heightAnchor.constraint(equalToConstant: 50),
           logInButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -75),
           logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
           logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
       ])
   }
    
    //MARK: - Login functions
    @objc private func logInButtonTapped(){
        //make sure all of the fields are non-nil and non-empty
        guard let username = usernameField.text,
              let password = passwordField.text,
              !username.isEmpty,
              !password.isEmpty else {
            showMissingFieldsAlert()
            return
        }
        
        User.login(username: username, password: password) { [weak self]
            result in
            
            switch result {
            case .success(let user):
                print("Successfully logged in user: \(user)")
                
                //post a notification that the user has successfully logged in
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
                
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to log in", message: description ?? "Unknown error", preferredStyle: .alert)
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

