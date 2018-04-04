//
//  DashboardViewModel.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/15/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import RxSwift

class DashboardViewModel {

  private var disposeBag = DisposeBag()
  var user = Variable<User?>(nil)

  init() {
    user.value = UserController.sharedInstance.currentUser
  }

  func logout() {
    UserController.sharedInstance.logout()
      .subscribe(
        onNext: { _ in
          AppRouter.sharedInstance.navigate(to: LoginRoute.login, with: .changeRoot)
        }
      ).disposed(by: disposeBag)
  }

}
