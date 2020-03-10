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
    
    @IBOutlet weak var addUserButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        tableView.register(UINib(nibName: "\(CustomTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(CustomTableViewCell.self)")
        configureUsers()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print(UserDefaults.standard.string(forKey: "lastSync")!)
        configureButtons()
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
        cell.textLabel?.text = String("\(user.name!) " + " \(user.surname!)")
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
        DispatchQueue.main.async {
            self.users = CoreDataManager.make(.Fetch)!
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: nil)
    }
    
    @IBAction func makeRefresh(_ sender: UIRefreshControl) {
        print("Refresh")
        var lastSync = User()
        let lastSyncRegister = UserDefaults.standard.string(forKey: "lastSync")
        lastSync.dateChanged = lastSyncRegister
        APIManager.syncServer(.Sync, lastSync: lastSync) {
            DispatchQueue.main.async {
                self.configureUsers()
                self.tableView.reloadData()
                sender.endRefreshing()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details",
            let destination = segue.destination as? DetailsViewController,
            let chosenIndex = self.tableView.indexPathForSelectedRow?.row
        {
            destination.user = users[chosenIndex]
        }
    }
    func configureButtons(){
        Helper.isConnected{
            status in
            if status == false{
                DispatchQueue.main.async {
                    self.addUserButton.isEnabled = false
                    self.refreshControl?.isEnabled = false
                }
            }
            else{
                DispatchQueue.main.async {
                    self.addUserButton.isEnabled = true
                    self.refreshControl?.isEnabled = true
                }
            }
        }
    }
}

