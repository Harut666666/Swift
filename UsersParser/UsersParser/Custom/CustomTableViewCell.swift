//
//  CustomTableViewCell.swift
//  UsersParser
//
//  Created by Harut on 2/16/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCustom: UIImageView!
    @IBOutlet weak var nameCustom: UILabel!

    func updateCellData( user: User) {
        if let name = user.name , let surname = user.surname {
             self.textLabel?.text = "\(name) \(surname)"
        }
        if let userImgString = user.img, !userImgString.isEmpty {
            if let url = URL(string: userImgString) {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        self.imageView?.image = image
                    }
                }
            } // placeholder
        }// placeholder image
    }
}
