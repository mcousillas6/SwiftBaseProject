//
//  AppRouter.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import UIKit

class AppRouter: BaseRouter {
  static let sharedInstance = AppRouter()

  init() {
    let user = UserController.sharedInstance.currentUser
    let initialRoute: Route = user != nil ? HomeRoute.dashboard : LoginRoute.login(username: AppDelegate.getUserNameFromDefaults())
    super.init(with: initialRoute)
  }

  required init(with route: Route) {
    super.init(with: route)
  }
}
