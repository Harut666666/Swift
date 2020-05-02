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
        configureTableView()
        configureUsers()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print(UserDefaults.standard.string(forKey: "lastSync")!)
        configureButtons()
        configureUsers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details",
            let destination = segue.destination as? DetailsViewController,
            let chosenIndex = self.tableView.indexPathForSelectedRow?.row
        {
            destination.user = users[chosenIndex]
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(CustomTableViewCell.self)", for: indexPath) as? CustomTableViewCell {
            cell.updateCellData(user: users[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: nil)
    }
    
    @IBAction func makeRefresh(_ sender: UIRefreshControl) {
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
    
    // MARK: - setup configure
    
    func configureTableView()  {
        guard let tableView = tableView else { return }
        tableView.register(UINib(nibName: "\(CustomTableViewCell.self)", bundle: nil),
        forCellReuseIdentifier: "\(CustomTableViewCell.self)")
    }
    
    func configureUsers() {
        self.users = CoreDataManager.make(.Fetch)!
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func configureButtons(){
        Helper.isConnected{ status in
            if status == false {
                DispatchQueue.main.async {
                    self.addUserButton.isEnabled = false
                    self.refreshControl?.isEnabled = false
                }
            }else{
                DispatchQueue.main.async {
                    self.addUserButton.isEnabled = true
                    self.refreshControl?.isEnabled = true
                }
            }
        }
    }
}

