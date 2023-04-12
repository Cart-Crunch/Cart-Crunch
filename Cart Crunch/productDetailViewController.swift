//
//  ViewController.swift
//  Cart Crunch
//
//  Created by Jonathan V. 4/12/2023 //

import UIKit

//product detail view controller, this page will display the details of our products

class productDetailViewController: UIViewController {
    
    //declaring our UI-imageview
    let prodView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "milk.jpeg"))
                    
        return image
        
    }()
    
    //declaring our product name label
    let productNameLabel: UILabel = {
        
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "Product name"
        
        return label
        
    }()
    // declaring our product category label
    let productCategoryLabel: UILabel = {
        
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "Product Category"
        
        return label
        
    }()
    
    // declaring productPrice
    let productPrice: UILabel = {
        
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.text = "Price"
        
        return label
        
    }()
    
    //we need to set up a table view to load similar products here
    //declare a tableview that will call the api and display similar products
    //that will allow users to navigate to those products.
    
    //view loader
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loads out UI
        setupUI()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }

    //UI set up function, sets up our UI
    private func setupUI(){
        let screenWidth = UIScreen.main.bounds.width
        
        view.addSubview(prodView)
        view.addSubview(productNameLabel)
        view.addSubview(productCategoryLabel)
        view.addSubview(productPrice)
        
        prodView.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //product image constraints
            prodView.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            prodView.widthAnchor.constraint(equalToConstant: 250),
            prodView.heightAnchor.constraint(equalToConstant: 250),
            prodView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //product name label constraints
            productNameLabel.topAnchor.constraint(equalTo: prodView.bottomAnchor, constant: 100),
            productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            //product category label constrains
            productCategoryLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 16),
            productCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            //product price label constraints
            productPrice.topAnchor.constraint(equalTo: prodView.bottomAnchor, constant: 100),
            productPrice.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64)  
        ]}
    }
}
