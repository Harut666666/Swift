//
//  User.swift
//  UsersParser
//
//  Created by Harut on 2/16/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import Foundation

struct User: Codable {
      var id: Int?
      var name: String?
      var surname: String?
      var email: String?
      var phone: String?
      var address: String?
      var img: String?
      var gender: String?
      var age: String?
      var about: String?
      var dateCreated: String?
      var dateChanged: String?
}

