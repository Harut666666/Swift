//
//  DetailsViewController.swift
//  UsersParser
//
//  Created by Harut on 2/16/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UINavigationControllerDelegate {
    
    var user:User!
    var goingForwards = true
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addresLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var aboutLable: UILabel!
    
    @IBOutlet weak var deleteUserButton: UIBarButtonItem!
    @IBOutlet weak var editUserButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.isConnected{
            status in
            if status == false{
                DispatchQueue.main.async {
                    self.deleteUserButton.isEnabled = false
                    self.editUserButton.isEnabled = false
                }
            }else{
                DispatchQueue.main.async {
                    self.deleteUserButton.isEnabled = true
                    self.editUserButton.isEnabled = true
                }
            }
        }
        updateUserData()
        if !goingForwards{
            let leftButton = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(backPressed(sender:)))
            self.navigationItem.leftBarButtonItem = leftButton
        }
        
    }
    
    @IBAction func removeUser(_ sender: UIBarButtonItem) {
        APIManager.make(.Delete, user: user)
        CoreDataManager.make(.Delete,user: user)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backPressed(sender:UIBarButtonItem)  {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? EditUserViewController
        if segue.identifier == "edit" {
            destination?.user = user
            destination?.updateMode = .update
        }
        let addressVC = segue.destination as? AddressLocationViewController
        if segue.identifier == "address"{
            addressVC?.address = user.address!
        }
    }
    
// WARNING -  UIIMageview extention
    func updateUserData()  {
        let url = URL(string: user.img!)
        if let data = try? Data(contentsOf: url!) {
            if let image = UIImage(data: data) {
                self.img.image = image
            }
        }
        nameLabel.text = user.name
        surnameLabel.text = user.surname
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        addresLabel.text = user.address
        ageLabel.text = user.age
        aboutLable.text = user.about
        genderLabel.text = user.gender
    }
}




