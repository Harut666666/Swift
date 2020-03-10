//
//  UserTableViewController.swift
//  UsersProject
//
//  Created by Harut on 3/2/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {

    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "\(CustomTableViewCell.self)", bundle:nil), forCellReuseIdentifier: "\(CustomTableViewCell.self)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CustomTableViewCell.self)", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = String("\(user.name!) " + "\(user.surname!)")
        if let userImgString = user.img, !userImgString.isEmpty {
            let url = URL(string: userImgString)
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    cell.imageView?.image = image
                }
            }
        }
        return cell
    }
}
