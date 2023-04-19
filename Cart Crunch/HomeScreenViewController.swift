//
//  HomeScreenViewController.swift
//  Cart Crunch
//
//  Created by Gabe Jones on 4/12/23.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    //MARK: - UIComponents
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.allowsSelection = true
        table.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: HomeScreenTableViewCell.identifier)
        return table
    }()
    
    let scrollView: UIScrollView = {
        //needed for the horizontally scrollable buttons
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let stackView: UIStackView = {
        //neede for the horizontally scrollable buttons
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 30
        return stackView
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search"
        search.barStyle = .default
        search.backgroundImage = UIImage()
        search.searchTextField.layer.borderColor = UIColor.black.cgColor
        search.searchTextField.layer.borderWidth = 1
        search.searchTextField.layer.cornerRadius = 12
        return search
    }()
    
    let testButton1: UIButton = {
        let button = UIButton()
        button.setTitle("Brand", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1.0)
        button.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let testButton2: UIButton = {
        let button = UIButton()
        button.setTitle("Brand", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1.0)
        button.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let testButton3: UIButton = {
        let button = UIButton()
        button.setTitle("Brand", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1.0)
        button.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let testButton4: UIButton = {
        let button = UIButton()
        button.setTitle("Brand", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1.0)
        button.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let testButton5: UIButton = {
        let button = UIButton()
        button.setTitle("Brand", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1.0)
        button.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Network manager
    //so we can access the methods from this class
    let networkManager = NetworkManager()

    //MARK: - Product object array
    var displayedProducts: [Product] = []
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Home"
        
        // MARK: - Networking
        networkManager.fetchProducts(searchTerm: "Ham") { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.displayedProducts = products
                    self.tableView.reloadData()
                    print(self.displayedProducts)
                }

            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - setupUI function
    private func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(testButton1)
        stackView.addArrangedSubview(testButton2)
        stackView.addArrangedSubview(testButton3)
        stackView.addArrangedSubview(testButton4)
        stackView.addArrangedSubview(testButton5)
        view.addSubview(tableView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            scrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 15),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.heightAnchor.constraint(equalToConstant: 30),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            testButton1.widthAnchor.constraint(equalToConstant: 60),
            testButton1.heightAnchor.constraint(equalToConstant: 30),
            
            testButton2.widthAnchor.constraint(equalToConstant: 60),
            testButton2.heightAnchor.constraint(equalToConstant: 30),

            testButton3.widthAnchor.constraint(equalToConstant: 60),
            testButton3.heightAnchor.constraint(equalToConstant: 30),
            
            testButton4.widthAnchor.constraint(equalToConstant: 60),
            testButton4.heightAnchor.constraint(equalToConstant: 30),
            
            testButton5.widthAnchor.constraint(equalToConstant: 60),
            testButton5.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: testButton1.bottomAnchor, constant: 25),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func onButtonTapped(_ sender: UIButton) {
        //adding toggle to the buttons for the color but this is also where we can let the user
        //turn off the brand filters by clicking the already selected button
        if sender.backgroundColor == UIColor(red: 249/255, green: 119/255, blue: 82/255, alpha: 1.0) {
            sender.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1.0)
        } else {
            sender.backgroundColor = UIColor(red: 249/255, green: 119/255, blue: 82/255, alpha: 1.0)
        }
        
        
        //change all the other buttons to the gray color
        let buttons = [testButton1, testButton2, testButton3, testButton4, testButton5]
        for button in buttons where button != sender {
            button.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1.0)
        }
    }
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenTableViewCell.identifier, for: indexPath) as? HomeScreenTableViewCell else {
            fatalError("Table view could not load")
        }
        //configuring the cells for reuse so they are all the same
        let product = displayedProducts[indexPath.row]
        cell.configure(with: product)
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //this is where we will navigate to the detail view for the product
    }
}
