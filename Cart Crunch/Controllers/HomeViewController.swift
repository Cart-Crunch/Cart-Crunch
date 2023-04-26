//
//  HomeScreenViewController.swift
//  Cart Crunch
//
//  Created by Gabe Jones on 4/12/23.
//

import UIKit
import Nuke

protocol HomeScreenViewControllerDelegate: AnyObject {
    func didSelectProduct(_ product: Product)
}

class HomeScreenViewController: UIViewController, ProductTableViewCellDelegate {
    
    public weak var delegate: HomeScreenViewControllerDelegate?
    
    let productTableView = ProductTableViewCell()
    
    let imagePrefetcher = ImagePrefetcher()
    
    //MARK: - UIComponents
    let tableViewWatchList: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.allowsSelection = true
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        return table
    }()
    
    let tableViewSearchResults: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.allowsSelection = true
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        return table
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search for an item..."
        search.barStyle = .default
        search.backgroundImage = UIImage()
        search.searchTextField.layer.borderColor = UIColor.black.cgColor
        search.searchTextField.layer.borderWidth = 1
        search.searchTextField.layer.cornerRadius = 12
        return search
    }()
    
    let watchListEmptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Watchlist is empty, search an item to add it to your watchlist"
        label.textColor = UIColor.lightGray
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
        
    let watchListEmptyImage: UIImageView = {
        let watchListImage = UIImageView(image: UIImage(systemName: "cart.badge.plus"))
        watchListImage.tintColor = UIColor.lightGray
        return watchListImage
    }()
    
    //MARK: - Network manager
    //so we can access the methods from this class
    let networkManager = NetworkManager()
    
    //MARK: - Product object array
    var product: [Product] = []
    
    func findImageURL(for images: [ImageMetaData], sizeName: String) -> String? {
        return images.first(where: { $0.size == sizeName })?.url
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayWatchListEmptyMessage()
        tableViewWatchList.delegate = self
        tableViewWatchList.dataSource = self
        tableViewSearchResults.delegate = self
        tableViewSearchResults.dataSource = self
        searchBar.delegate = self
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Home"
    }
    
    // MARK: - hide all backButtonTitles
    override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    //MARK: - setupUI function
    private func setupUI() {
        productTableView.delegate = self
        view.addSubview(searchBar)
        view.addSubview(tableViewWatchList)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableViewWatchList.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            tableViewWatchList.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 25),
            tableViewWatchList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableViewWatchList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewWatchList.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - ProductTableViewDelegate
    func productTableView(_ product: ProductTableViewCell, didSelectProduct _: Product) {
        return
    }
    
    //MARK: - Display watch list empty label and image
    func displayWatchListEmptyMessage() {
        //we will have to change this from displayed products to our array of watchlist items
        //whenever we create it
        if product.isEmpty {
            view.addSubview(watchListEmptyImage)
            view.addSubview(watchListEmptyLabel)
                
            watchListEmptyImage.translatesAutoresizingMaskIntoConstraints = false
            watchListEmptyLabel.translatesAutoresizingMaskIntoConstraints = false
                    
            NSLayoutConstraint.activate([
                watchListEmptyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                watchListEmptyImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                watchListEmptyImage.widthAnchor.constraint(equalToConstant: 50),
                watchListEmptyImage.heightAnchor.constraint(equalToConstant: 45),
                            
                watchListEmptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                watchListEmptyLabel.topAnchor.constraint(equalTo: watchListEmptyImage.bottomAnchor, constant: 10),
                watchListEmptyLabel.widthAnchor.constraint(equalToConstant: 300),
            ])
                        
            tableViewWatchList.isHidden = true
        }
    }
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell else {
            fatalError("Table view could not load")
        }
        //configuring the cells for reuse so they are all the same
        let product = product[indexPath.row]
        cell.configure(with: product)
        cell.backgroundColor = .white
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = product[indexPath.row]
        delegate?.didSelectProduct(product)
        
        // Open Product Detail Controller for Product
        let productVC = ProductDetailViewController()
        // unsubscribe product data to the detail view controller
        productVC.product = product
        productVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(productVC, animated: true)
    }
}

//MARK: - Search bar extension/functions
extension HomeScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
                    //If the search bar is empty, remove the search results table from the view and show the watch list table
                    tableViewSearchResults.removeFromSuperview()
                    tableViewWatchList.isHidden = false
                } else {
                    //If the search bar has text, hide the watchlist table view and show the search results table
                    tableViewWatchList.isHidden = true
                    view.addSubview(tableViewSearchResults)
                    tableViewSearchResults.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        tableViewSearchResults.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 25),
                        tableViewSearchResults.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                        tableViewSearchResults.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        tableViewSearchResults.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                    ])
                    //update the search results table based on the search text here
                    networkManager.fetchProducts(searchTerm: searchText) { result in
                        switch result {
                        case .success(let products):
                            DispatchQueue.main.async {
                                self.product = products
                                
                                // Prefetch images
                                let urls = products.compactMap { self.findImageURL(for: $0.images.first?.sizes ?? [], sizeName: "medium") }.compactMap { URL(string: $0) }
                                self.imagePrefetcher.startPrefetching(with: urls)
                                
                                self.tableViewSearchResults.reloadData()
                            }
                            
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
    }
}
