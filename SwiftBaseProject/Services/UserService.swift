//
//  UserService.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/15/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import Moya

enum UserService {

  case login(username: String, password: String)
  case logout
}

extension UserService: TargetType {

  var path: String {
    switch self {
    case .login:
      return "/session/login"
    case .logout:
      return "/session/logout"
    }
  }

  var method: Moya.Method {
    return .post
  }

  var task: Task {
    switch self {
    case .login(let username, let password):
      return .requestParameters(
        parameters: ["user_name": username, "password": password],
        encoding: JSONEncoding.default
      )
    case .logout:
      return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
    }
  }

  var headers: [String: String]? {
    return [:]
  }

}

class UserServiceManager: BaseManager<UserService> {}
