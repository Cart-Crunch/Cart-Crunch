//
//  SheetViewController.swift
//  Cart Crunch
//
//  Created by Jonathan Velez on 4/20/23.
//

import Foundation
import UIKit

class SheetViewController: UITableViewController  {

    let items = Range(0...20).map {_ in "($0)"}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ItemCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)

        var content = cell.defaultContentConfiguration()

        content.text = "Item \(indexPath.row)"

        cell.contentConfiguration = content

        return cell
    }
}
