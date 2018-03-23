//
//  UserDataAccess.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/15/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import RxSwift

class UserDataAccess: BaseDataAccess {

  var currentUser: User? = User(username: "juan", email: "j@j.j", phone: nil)

  func getUser(with username: String) -> Observable<User?> {
    if username == currentUser?.username {
      return Observable.just(currentUser)
    } else {
      return Observable.empty()
    }
  }

  func save(user: User) {
    currentUser = user
  }

  func deleteCurrentUser() {
    currentUser = nil
  }

}
