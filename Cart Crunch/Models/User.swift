//
//  User.swift
//  Cart Crunch
//
//  Created by TaeVon Lewis on 4/19/23.
//

import Foundation
import ParseSwift

struct User: ParseUser {
        // These are required by `ParseObject`.
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?
    var lastPostedDate: Date?
    
        // These are required by `ParseUser`.
    var username: String?
    var email: String?
    var emailVerified: Bool?
    var password: String?
    var authData: [String: [String: String]?]?
}
