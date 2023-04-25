//
//  ProductTableViewCell.swift
//  Cart Crunch
//
//  Created by Marlon Johnson on 4/22/23.
//

import UIKit
import Nuke

protocol ProductTableViewCellDelegate: AnyObject {
    func productTableView(_ product: ProductTableViewCell, didSelectProduct product: Product)
}

class ProductTableViewCell: UITableViewCell {
    
    static let identifier = "ProductTableViewCell"
    public weak var delegate: ProductTableViewCellDelegate?
    
    // MARK: - UIComponents
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    let productBrandNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let productOldPriceLabel: UILabel = {
        let label = UILabel()
        let textColor = hexStringToUIColor(hex: "#C5C5C5")
        label.textColor = textColor
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product) {
        productNameLabel.text = product.description
        
        productBrandNameLabel.text = product.brand ?? "No Brand"
        
        let oldPriceStrikeThrough: NSMutableAttributedString = NSMutableAttributedString(string: "$27.90")
        
        oldPriceStrikeThrough.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: oldPriceStrikeThrough.length))
        
        
        guard let priceRegular = findProductPricing(for: product.items.first!.price) else { return }
        productOldPriceLabel.text = "$\(String(priceRegular))"
        
        
        guard let pricePromo = findProductPromo(for: product.items.first!.price) else { return }
        productNewPriceLabel.text = String(pricePromo)
        
        
        if priceRegular == nil && pricePromo != 0.0 {
            productOldPriceLabel.attributedText = oldPriceStrikeThrough
        }
        
        if pricePromo == 0.0 {
            productNewPriceLabel.text = ""
        } else {
            productNewPriceLabel.text = String(pricePromo)
        }
        
        
        let desiredSizeName = "medium" // Change this to the size name you want to use
        
        guard let imageURLString = findImageURL(for: product.images.first?.sizes ?? [], sizeName: desiredSizeName) else { return }
        
        let imageURL = URL(string: imageURLString)
        Nuke.loadImage(with: imageURL!, into: productImageView)
    }

    func findImageURL(for images: [ImageMetaData], sizeName: String) -> String? {
        
        return images.first(where: { $0.size == sizeName })?.url
    }
  
    func findProductPricing(for items: PriceMetaData) -> Double? {
        return items.regular
    }
    
    func findProductPromo(for items: PriceMetaData) -> Double? {
        return items.promo
    }


    
    // MARK: - Setup UI
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
            productImageView.heightAnchor.constraint(equalToConstant: 50),
            productImageView.widthAnchor.constraint(equalToConstant: 50),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            productNameLabel.trailingAnchor.constraint(equalTo: productOldPriceLabel.leadingAnchor, constant: -90),
            
            productBrandNameLabel.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: -8),
            productBrandNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            
            
            productOldPriceLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -23),
            productOldPriceLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8),
            productOldPriceLabel.leadingAnchor.constraint(equalTo: productNameLabel.trailingAnchor, constant: 0),
            
            productNewPriceLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            productNewPriceLabel.topAnchor.constraint(equalTo: productOldPriceLabel.bottomAnchor, constant: 15)
        ])
    }
}


extension ProductTableViewCell: HomeScreenViewControllerDelegate {
    func didSelectProduct(_ product: Product) {
        delegate?.productTableView(self, didSelectProduct: product)
    }
}



//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//@available(iOS 13.0, *)
//struct ProductTableViewCell_Preview: PreviewProvider {
//    static var previews: some View {
//        UIViewPreview {
//            ProductTableViewCell()
//        }.previewLayout(.sizeThatFits)
//            .padding(10)
//    }
//}
//
//#endif
