//
//  ViewController.swift
//  Cart Crunch
//
//  Created by Jonathan V. 4/12/2023 //

import UIKit
import Nuke

class ProductDetailViewController: UIViewController {
    
    var product: Product?
    var productWatchList: [Product]?
    var tableViewWatchList: UITableView?
    
    // MARK: - Network manager
    //so we can access the methods from this class
    let networkManager = NetworkManager()
    
    lazy var watchListButton: UIButton = {
        let button = UIButton()
        if let product = self.product, DataStore.shared.watchlist.contains(where: { $0.productId == product.productId }) {
                button.setTitle(" Added to WatchList", for: .normal)
                button.setImage(UIImage(systemName: "checkmark"), for: .normal)
                button.imageView?.tintColor = .white
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .black
                button.translatesAutoresizingMaskIntoConstraints = false
                button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .semibold)
                button.layer.cornerRadius = 4
                button.layer.borderWidth = 2
            } else {
                button.setTitle("+ Add to WatchList", for: .normal)
                button.setImage(UIImage(systemName: "plus_icon"), for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = hexStringToUIColor(hex: "#F9F9F9")
                button.translatesAutoresizingMaskIntoConstraints = false
                button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .semibold)
                button.layer.cornerRadius = 4
                button.layer.borderWidth = 2
            }
        
        return button
    }()
    
    //declaring our UI-imageview
    let productImageView: UIImageView = {
        // MARK: - Only for Testing Purposes
        let imageView = UIImageView(image: UIImage(named: "placeholder-image.jpeg"))
        return imageView
    }()
    
    //declaring our product name label
    let productNameLabel: UILabel = {
        
        let label = UILabel()
        let textColor = hexStringToUIColor(hex: "#5B8F94")
        
        label.textColor = textColor
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 3
        // MARK: - Only for Testing Purposes
        label.text = "Kroger 2% Reduced Fat Milk"
        
        return label
        
    }()
    // declaring our product category label
    let productCategoryLabel: UILabel = {
        
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        // MARK: - Only for Testing Purposes
        label.text = "Product Category"
        
        return label
        
    }()
    
    // declaring productPrice
    let productPrice: UILabel = {
        
        let label = UILabel()
        let textColor = hexStringToUIColor(hex: "#344C5C")
        
        label.textColor = textColor
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        // MARK: - Only for Testing Purposes
        label.text = "$21.90"
        
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // loads out UI
        setupUI()
        // loads the data
        setupData()
        //loads the button targets
        addButtonTargets()
        //make our watchlist persistent and passable accross views
        productWatchList = DataStore.shared.watchlist
        
        navigationController?.navigationBar.tintColor = hexStringToUIColor(hex: "344C5C")
        if #available(iOS 13.0, *) {
            navigationController?.navigationItem.backButtonDisplayMode = .minimal
        } else {
            // Fallback on earlier versions
            navigationController?.navigationItem.backButtonTitle = ""
        }
        view.backgroundColor = .white
    }
    
    private func addButtonTargets() {
        watchListButton.addTarget(self, action: #selector(watchListButtonSelected), for: .touchUpInside)
    }
    
    private func findImageURL(for images: [ImageMetaData], sizeName: String) -> String? {
        
        return images.first(where: { $0.size == sizeName })?.url
    }
    
    private func findProductPricing(for items: PriceMetaData) -> Double? {
        return items.regular
    }
    
    //UI set up function, sets up our UI
    private func setupUI() {
        view.addSubview(productImageView)
        view.addSubview(productPrice)
        view.addSubview(productNameLabel)
        view.addSubview(productCategoryLabel)
        view.addSubview(watchListButton)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //product image constraints
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            productImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            productImageView.widthAnchor.constraint(equalToConstant: 393),
            productImageView.heightAnchor.constraint(equalToConstant: 300),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            // Product Price label constraints
            productPrice.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 47),
            productPrice.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            // Product Description constraints
            productNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            productNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            productNameLabel.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 10),
            
            
            // product category label constrains
            productCategoryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            productCategoryLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 16),
            
            // WatchList Button
            watchListButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            watchListButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            watchListButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            watchListButton.widthAnchor.constraint(equalToConstant: 318),
            watchListButton.heightAnchor.constraint(equalToConstant: 47),
        ])
    }
    
    private func setupData() {
        //changed this to extra large for better resolution
        let desiredSizeName = "xlarge" // Change this to the size name you want to use
        
        let product = product
        // MARK: - Networking
        networkManager.fetchProducts(searchTerm: "Ham") { result in
            switch result {
            case .success:
                DispatchQueue.main.async { [self] in
                    self.product = product
                    guard let imageURLString = findImageURL(for: product?.images.first?.sizes ?? [], sizeName: desiredSizeName) else { return
                        
                    }
                    
                    guard let priceRegular = findProductPricing(for: product!.items.first!.price) else { return }
                    productPrice.text = "$\(String(priceRegular))"
                    
                    
                    let imageURL = URL(string: imageURLString)
                    Nuke.loadImage(with: imageURL!, into: self.productImageView)
                    
                    
                    self.productNameLabel.text = product?.description
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
    @objc private func watchListButtonSelected() {
        guard let product = product else { return }
        let homeViewController = HomeScreenViewController()
        let isAlreadyInWatchlist = DataStore.shared.watchlist.contains { $0.productId == product.productId }
        if !isAlreadyInWatchlist {
            //if the data isn't already in our watchlist add it to the watchlist and change the button
            //color and label
            DataStore.shared.watchlist.append(product)
            watchListButton.setTitle(" Added to WatchList", for: .normal)
            watchListButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            watchListButton.imageView?.tintColor = .white
            watchListButton.setTitleColor(.white, for: .normal)
            watchListButton.backgroundColor = .black
            watchListButton.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .semibold)
            watchListButton.layer.cornerRadius = 4
            watchListButton.layer.borderWidth = 2
            navigationController?.popViewController(animated: true)
        } else {
            //if the product is already in the watchlist we are going to remove it
            //and change the button color and label
            if let index = DataStore.shared.watchlist.firstIndex(where: { $0.productId == product.productId }) {
                DataStore.shared.watchlist.remove(at: index)
            }
            watchListButton.setTitle("+ Add to WatchList", for: .normal)
            watchListButton.setImage(UIImage(systemName: "plus_icon"), for: .normal)
            watchListButton.setTitleColor(.black, for: .normal)
            watchListButton.backgroundColor = hexStringToUIColor(hex: "#F9F9F9")
            watchListButton.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .semibold)
            watchListButton.layer.cornerRadius = 4
            watchListButton.layer.borderWidth = 2
            navigationController?.popViewController(animated: true)
        }
    }
}
