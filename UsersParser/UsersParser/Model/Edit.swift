//
//  Edit.swift
//  UsersParser
//
//  Created by Harut on 3/1/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import Foundation

enum Edit: String {
    case Add = "add"
    case Delete = "delete"
    case Update = "update"
    case Sync = "sync"
    case FullSync = "fullsync"
    case Fetch
}
