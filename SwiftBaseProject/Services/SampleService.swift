//
//  SampleService.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import Moya

enum SampleService {

  case login(email: String, password: String)
  case logout()

}

extension SampleService: TargetType {

  var path: String {
    switch self {
    case .login(_, _):
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
    case .login(let email, let password):
      return .requestParameters(
        parameters: ["email": email, "password": password],
        encoding: JSONEncoding.default
      )
    case .logout:
      return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
    }
  }

  var headers: [String : String]? {
    return [:]
  }

}

class SampleServiceManager: BaseManager<SampleService> {}
