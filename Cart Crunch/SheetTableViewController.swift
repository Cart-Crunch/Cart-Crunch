//
//  SheetViewController.swift
//  Cart Crunch
//
//  Created by Jonathan Velez on 4/20/23.
//

import UIKit

class SheetViewController: UITableViewController {
        // MARK: - Properties
    var fetchedStores: [Store] = []
    
        // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
        // MARK: - TableView Setup
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ItemCell")
    }
    
        // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedStores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let store = fetchedStores[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = store.name
        
        cell.contentConfiguration = content
        
        return cell
    }
}


