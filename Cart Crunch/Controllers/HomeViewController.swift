//
//  HomeScreenViewController.swift
//  Cart Crunch
//
//  Created by Gabe Jones on 4/12/23.
//

import UIKit

protocol HomeScreenViewControllerDelegate: AnyObject {
    func didSelectProduct(_ product: Product)
}

class HomeScreenViewController: UIViewController, ProductTableViewCellDelegate {
    
    public weak var delegate: HomeScreenViewControllerDelegate?
    
    let productTableView = ProductTableViewCell()
    
    
    //MARK: - UIComponents
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.allowsSelection = true
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
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
    var product: [Product] = []
    
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
                    self.product = products
                    self.tableView.reloadData()
                    print(self.product)
                }
                
            case .failure(let error):
                print(error)
            }
        }
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
    
    // MARK: ProductTableViewDelegate
    
    func productTableView(_ product: ProductTableViewCell, didSelectProduct _: Product) {
        return
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



//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//let deviceName: [String] = [
//    "iPhone 14 Pro Max"
//]
//
//@available(iOS 13.0, *)
//struct HomeScreenViewController_Preview: PreviewProvider {
//    static var previews: some View {
//        ForEach(deviceName, id: \.self) { deviceName in
//            UIViewControllerPreview {
//                HomeScreenViewController()
//            }.previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
//    }
//}
//#endif
