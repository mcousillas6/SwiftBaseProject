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
  private var router: AppRouter
  var user = Variable<User?>(nil)

  init(router: AppRouter) {
    self.router = router
    user.value = UserController.sharedInstance.currentUser
  }

  func logout() {
    UserController.sharedInstance.logout()
      .subscribe(
        onNext: { [weak self] _ in
          self?.router.logout()
        }
      ).disposed(by: disposeBag)
  }

}
