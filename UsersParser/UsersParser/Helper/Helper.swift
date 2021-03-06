//
//  Helper.swift
//  UsersParser
//
//  Created by Harut on 3/10/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import Foundation
import Network
import UIKit

struct Helper {
    static func isConnected(completion: @escaping(Bool)->()){
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            completion(path.status == .satisfied)
        }
    }
}

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime])
}

// UsersParser+Date.swift
extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}


// UsersParser+String.swift
extension String {
    var iso8601: Date? {
        return Formatter.iso8601.date(from: self)
    }
}
