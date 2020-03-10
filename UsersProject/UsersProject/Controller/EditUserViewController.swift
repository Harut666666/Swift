//
//  EditUserViewController.swift
//  UsersProject
//
//  Created by Harut on 3/6/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import UIKit

class EditUserViewController: UIViewController {
    var user = User()
    var updateMode = false
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var imgUrlTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var aboutTextField: UITextField!
    
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if updateMode == true{
            editButton.setTitle("Update", for: .normal)
        }else{
            editButton.setTitle("Add", for: .normal)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        updateUser()
    }
    
    @IBAction func addUser(_ sender: UIButton) {
        setUser()
        if !updateMode{
            user.dateChanged = Date().iso8601
            APIManager.editUser(mode: "adduser", user: user)
            navigationController?.popViewController(animated: true)
        }else{
            APIManager.editUser(mode:"updateuser", user: user)
            _ = CoreDataManager.make(.Update, user: user)
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
//            destinationVC.user = user.self
//            desti
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            destinationVC.user = self.user
            destinationVC.goingForwards = false
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    

    
    func updateUser(){
        if updateMode == true{
            editButton.setTitle("Update", for: .normal)
            nameTextField.text = user.name
            surnameTextField.text = user.surname
            emailTextField.text = user.email
            phoneTextField.text = user.phone
            addressTextField.text = user.address
            imgUrlTextField.text = user.img
            genderTextField.text = user.gender
            ageTextField.text = user.age
            aboutTextField.text = user.about
        }
    }
    
    func setUser(){
            user = User(
            id:user.id ,
            name: nameTextField.text,
            surname: surnameTextField.text,
            email: emailTextField.text,
            phone: phoneTextField.text,
            address: addressTextField.text,
            img:  imgUrlTextField.text,
            gender: genderTextField.text,
            age: ageTextField.text,
            about: aboutTextField.text,
            dateChanged: Date().iso8601)
    }
    
}
