//
//  LandingPageViewController.swift
//  Cart Crunch
//
//  Created by Gabe Jones on 4/20/23.
//

import UIKit

class LandingPageViewController: UIViewController {
    
    //MARK: - UIComponents
    let trackLabel: UILabel = {
        let label = UILabel()
        label.text = "Track."
        label.font = UIFont(name: "Arial-BoldMT", size: 35)
        label.textColor = .white
        return label
    }()
   
    let chartLabel: UILabel = {
        let label = UILabel()
        label.text = "Chart."
        label.font = UIFont(name: "Arial-BoldMT", size: 35)
        label.textColor = .white
        return label
    }()
   
    let findLabel: UILabel = {
        let label = UILabel()
        label.text = "Find."
        label.font = UIFont(name: "Arial-BoldMT", size: 35)
        label.textColor = .white
        return label
    }()
   
    let allYourFavoriteLabel: UILabel = {
        let label = UILabel()
        label.text = "All your favorite"
        label.font = UIFont(name: "Arial-BoldMT", size: 35)
        label.textColor = .white
        return label
    }()
   
    let itemsLabel: UILabel = {
        let label = UILabel()
        label.text = "items"
        label.font = UIFont(name: "Arial-BoldMT", size: 35)
        label.textColor = .white
        return label
    }()
   
    let onTheGoLabel: UILabel = {
        let label = UILabel()
        label.text = "on the go."
        label.font = UIFont(name: "Arial-BoldMT", size: 35)
        label.textColor = UIColor(red: 249/255, green: 118/255, blue: 82/255, alpha: 1.0)
        return label
    }()
   
    let alreadyHaveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
   
    let logInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(UIColor(red: 131/255, green: 192/255, blue: 175/255, alpha: 1.0), for: .normal)
        return button
    }()
   
    let getStartedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 249/255, green: 118/255, blue: 82/255, alpha: 1)
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
        return button
    }()
   
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CartCrunchLogo")
        return imageView
    }()
   
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Cart Crunch"
        label.font = UIFont(name: "Arial-BoldMT", size: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
   
    //MARK: - setupButtonTargets
    func setupButtonTargets() {
        getStartedButton.addTarget(self, action: #selector(onGetStartedButtonTapped), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(onLogInButtonTapped), for: .touchUpInside)
       
    }

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButtonTargets()
        view.backgroundColor = UIColor(red: 48/255, green: 73/255, blue: 93/255, alpha: 1.0)
    }
    
    //MARK: - setupUI
    private func setupUI() {
        view.addSubview(trackLabel)
        view.addSubview(chartLabel)
        view.addSubview(findLabel)
        view.addSubview(allYourFavoriteLabel)
        view.addSubview(itemsLabel)
        view.addSubview(onTheGoLabel)
        view.addSubview(alreadyHaveAnAccountLabel)
        view.addSubview(getStartedButton)
        view.addSubview(logInButton)
        view.addSubview(logoLabel)
        view.addSubview(logoImageView)
       
        trackLabel.translatesAutoresizingMaskIntoConstraints = false
        chartLabel.translatesAutoresizingMaskIntoConstraints = false
        findLabel.translatesAutoresizingMaskIntoConstraints = false
        allYourFavoriteLabel.translatesAutoresizingMaskIntoConstraints = false
        itemsLabel.translatesAutoresizingMaskIntoConstraints = false
        onTheGoLabel.translatesAutoresizingMaskIntoConstraints = false
        alreadyHaveAnAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            trackLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),
            trackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
           
            chartLabel.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: 10),
            chartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
           
            findLabel.topAnchor.constraint(equalTo: chartLabel.bottomAnchor, constant: 10),
            findLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
           
            allYourFavoriteLabel.topAnchor.constraint(equalTo: findLabel.bottomAnchor, constant: 10),
            allYourFavoriteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
           
            itemsLabel.topAnchor.constraint(equalTo: allYourFavoriteLabel.bottomAnchor, constant: 10),
            itemsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
           
            onTheGoLabel.topAnchor.constraint(equalTo: itemsLabel.topAnchor),
            onTheGoLabel.leadingAnchor.constraint(equalTo: itemsLabel.trailingAnchor, constant: 5),
           
            getStartedButton.heightAnchor.constraint(equalToConstant: 50),
            getStartedButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -120),
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
           
            alreadyHaveAnAccountLabel.topAnchor.constraint(equalTo: getStartedButton.bottomAnchor, constant: 10),
            alreadyHaveAnAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
           
            logInButton.topAnchor.constraint(equalTo: getStartedButton.bottomAnchor, constant: 3),
            logInButton.leadingAnchor.constraint(equalTo: alreadyHaveAnAccountLabel.trailingAnchor, constant: 5),
           
            logoImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 35),
            logoImageView.widthAnchor.constraint(equalToConstant: 35),
           
            logoLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
   
    //MARK: - Button functions
    @objc private func onGetStartedButtonTapped() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
   
    @objc private func onLogInButtonTapped() {
        navigationController?.pushViewController(LogInViewController(), animated: true)
    }
 }

