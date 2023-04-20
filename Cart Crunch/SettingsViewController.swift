//
//  SettingsViewController.swift
//  Cart Crunch
//
//  Created by Gabe Jones on 4/12/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let logOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    
    private func addButtonTargets() {
        logOutButton.addTarget(self, action: #selector(onLogoutButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addButtonTargets()
        view.backgroundColor = .white
    }
    
    //MARK: - setupUI
    private func setupUI() {
        view.addSubview(logOutButton)
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    //MARK: - logout button functions
    @objc private func onLogoutButtonTapped() {
        showConfirmLogoutAlert()
    }
    
    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of your account?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
