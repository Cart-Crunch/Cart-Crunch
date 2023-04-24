//
//  ViewController.swift
//  Cart Crunch
//
//  Created by Jonathan V. 4/12/2023 //

import UIKit
import Nuke

//product detail view controller, this page will display the details of our products

class ProductDetailViewController: UIViewController {
    
    var product: Product?
    
    //MARK: - Network manager
    //so we can access the methods from this class
    let networkManager = NetworkManager()
    
//    lazy var mutateProductUIView: UIView = {
//        let productContainer = UIView()
//        productContainer.frame.size.width = 357
//        productContainer.frame.size.height = 74
////        productContainer.sizeToFit()
//        productContainer.translatesAutoresizingMaskIntoConstraints = false
//        productContainer.backgroundColor = .purple
//        productContainer.addSubview(watchListButton)
//        return productContainer
//    }()
    
    let watchListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to WatchList", for: .normal)
        button.frame.size.width = 357
        button.frame.size.height = 74
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = hexStringToUIColor(hex: "#F9F9F9")
        button.titleLabel?.font = .systemFont(ofSize: 12.0, weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .fill
        // @Deprecated: Can't find a better Solution right now
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
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
        label.numberOfLines = 2
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
    
    //we need to set up a table view to load similar products here
    //declare a tableview that will call the api and display similar products
    //that will allow users to navigate to those products.
    
    //view loader
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // loads out UI
        setupUI()
        // loads the data
        setupData()
        
        navigationController?.navigationBar.tintColor = hexStringToUIColor(hex: "344C5C")
        if #available(iOS 13.0, *) {
            navigationController?.navigationItem.backButtonDisplayMode = .minimal
        } else {
            // Fallback on earlier versions
            navigationController?.navigationItem.backButtonTitle = ""
        }
        view.backgroundColor = .white
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
            productImageView.widthAnchor.constraint(equalToConstant: 393),
            productImageView.heightAnchor.constraint(equalToConstant: 261),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            // Product Price label constraints
            productPrice.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 47),
            productPrice.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            // Product Description constraints
            productNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            productNameLabel.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 10),
            
            
//            productPrice.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            
            //product name label constraints
//            productNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            productNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -104),
//            productNameLabel.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: -40),
//            productNameLabel.bottomAnchor.constraint(equalTo: watchListButton.topAnchor, constant: -209),

//            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 100),
//            productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            // product category label constrains
            productCategoryLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 16),
            productCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            // Mutate Product Constrants
            // This was for the possible of grouping the buttons in a container
//            mutateProductUIView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            mutateProductUIView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            mutateProductUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            mutateProductUIView.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 209),
            
            // WatchList Button
            watchListButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            watchListButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            watchListButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            watchListButton.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 209),
        ])
    }
    
    private func setupData() {
        let desiredSizeName = "medium" // Change this to the size name you want to use
        
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
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

let deviceName: [String] = [
    "iPhone 14 Pro Max"
]

@available(iOS 13.0, *)
struct ProductDetail_Preview: PreviewProvider {
    static var previews: some View {
        ForEach(deviceName, id: \.self) { deviceName in
            UIViewControllerPreview {
                ProductDetailViewController()
            }.previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
#endif
