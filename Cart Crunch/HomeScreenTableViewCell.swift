//
//  HomeScreenTableViewCell.swift
//  Cart Crunch
//
//  Created by Gabe Jones on 4/17/23.
//

import UIKit
import Nuke

class HomeScreenTableViewCell: UITableViewCell {
    
    static let identifier = "HomeScreenTableViewCell"
    
    //MARK: - UIComponents
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    let productBrandNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    let productOldPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let productNewPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 249/255, green: 119/255, blue: 82/255, alpha: 1.0)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    //this is hard coded for now but eventually we will pass data from the api here
    //we can use the nuke package again to grab the image from the api
    func configure(with product: Product, findImageURL: (_ images: [ImageMetaData], _ sizeName: String) -> String?) {
        
        productNameLabel.text = product.description
        
        productBrandNameLabel.text = product.brand ?? "No Brand"
        
        let oldPriceStrikeThrough: NSMutableAttributedString = NSMutableAttributedString(string: "$27.90")
        
        oldPriceStrikeThrough.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: oldPriceStrikeThrough.length))
        
        productOldPriceLabel.attributedText = oldPriceStrikeThrough
        
        productNewPriceLabel.text = String(product.items.first?.price?.regular ?? 0)
        
        let desiredSizeName = "medium"
        guard let imageURLString = findImageURL(product.images.first?.sizes ?? [], desiredSizeName) else { return }
        if let imageURL = URL(string: imageURLString) {
            Nuke.loadImage(with: imageURL, into: productImageView)
        }

    }
    
//    func findImageURL(for images: [ImageMetaData], sizeName: String) -> String? {
//        return images.first(where: { $0.size == sizeName })?.url
//    }

    //MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productBrandNameLabel)
        contentView.addSubview(productOldPriceLabel)
        contentView.addSubview(productNewPriceLabel)
        contentView.addSubview(productImageView)
        
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productBrandNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productOldPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productNewPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            productNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220), 
            
            productBrandNameLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 15),
            productBrandNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            
            productOldPriceLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            productOldPriceLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            
            productNewPriceLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            productNewPriceLabel.topAnchor.constraint(equalTo: productOldPriceLabel.bottomAnchor, constant: 15)
        ])
    }
}
