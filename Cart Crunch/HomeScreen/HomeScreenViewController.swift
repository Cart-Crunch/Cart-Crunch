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
        view.addSubview(tableView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 25),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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
