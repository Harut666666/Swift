//
//  UserTableViewController.swift
//  UsersParser
//
//  Created by Harut on 2/16/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {

    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "\(CustomTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(CustomTableViewCell.self)")
        configureUsers()
    }
    override func viewDidAppear(_ animated: Bool) {
        print(UserDefaults.standard.string(forKey: "lastSync")!)
           configureUsers()
       }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CustomTableViewCell.self)", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = String("\(user.name!) " + " \(user.dateChanged!)")
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
    
    func configureUsers(){
//        APIManager.getUsers(completion: {
//            users in
//            DispatchQueue.main.async {
//                self.users = users
//                self.tableView.reloadData()
//            }
//        })
            self.users = CoreDataManager.make(.Fetch)!
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
            
        print("Config in")
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: nil)
    }
    
    @IBAction func makeRefresh(_ sender: UIRefreshControl) {
        
            _ = CoreDataManager.make(.Sync)
             self.configureUsers()
             print("Config end")
             sender.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "details",
               let destination = segue.destination as? DetailsViewController,
               let chosenIndex = self.tableView.indexPathForSelectedRow?.row
           {
               destination.user = users[chosenIndex]
           }
       }
}
