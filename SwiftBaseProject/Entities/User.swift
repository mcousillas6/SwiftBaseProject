//
//  User.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/15/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation

struct User: Codable {

  let username: String
  let email: String
  let phone: String?
}

extension User {

  enum CodingKeys: String, CodingKey {
    case username = "user_name"
    case email = "email"
    case phone = "phone"
  }
}
