//
//  EditUserViewController.swift
//  UsersParser
//
//  Created by Harut on 2/16/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import UIKit

class EditUserViewController: UIViewController {
    
    var user = User()
    var updateMode = false
    
    @IBOutlet weak var nameTextFild: UITextField!
    @IBOutlet weak var surnameTextFild: UITextField!
    @IBOutlet weak var emailTextFild: UITextField!
    @IBOutlet weak var phoneTextFild: UITextField!
    @IBOutlet weak var addressTextFild: UITextField!
    @IBOutlet weak var imgUrlTextFild: UITextField!
    @IBOutlet weak var genderTextFild: UITextField!
    @IBOutlet weak var aboutTextFild: UITextField!
    
    @IBOutlet weak var ageTextFild: UITextField!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if updateMode == true {
            editButton.setTitle("Update", for: .normal)
        }else{
            editButton.setTitle("Add", for: .normal)
        }
    }
  
    @IBAction func addUser(_ sender: UIButton) {
        setUser()

      if !updateMode {
            user.dateCreated = Date().iso8601
            APIManager.make(.Add, user: user)
            navigationController?.popViewController(animated: true)
        } else {
            APIManager.make(.Update, user: user)
        
        
            CoreDataManager.make(.Update, user: user)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        destinationVC.user = self.user
        destinationVC.goingForwards = false
        navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
   
    
    
    override func viewDidAppear(_ animated: Bool) {
           updateUser()
    }
    
    func updateUser(){
        if updateMode == true{
            editButton.setTitle("Update", for: .normal)
            nameTextFild.text = user.name
            surnameTextFild.text = user.surname
            emailTextFild.text = user.email
            phoneTextFild.text = user.phone
            addressTextFild.text = user.address
            imgUrlTextFild.text = user.img
            genderTextFild.text = user.gender
            ageTextFild.text = user.age
            aboutTextFild.text = user.about
        }
    }
    

    func setUser(){
            user = User (
            id:user.id ,
            name: nameTextFild.text,
            surname: surnameTextFild.text,
            email: emailTextFild.text,
            phone: phoneTextFild.text,
            address: addressTextFild.text,
            img:  imgUrlTextFild.text,
            gender: genderTextFild.text,
            age: ageTextFild.text,
            about: aboutTextFild.text,
            dateChanged: Date().iso8601)
    }
}
