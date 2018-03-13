//
//  LoginViewModel.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel {

  private var disposeBag = DisposeBag()
  private var router: AppRouter
  var userName = Variable<String?>(nil)
  var password = Variable<String?>(nil)
  var canSubmit = Variable<Bool>(false)

  init(router: AppRouter) {
    self.router = router
    Observable.combineLatest(
      userName.asObservable(),
      password.asObservable()
    ).subscribe(
      onNext: { [unowned self] (user, pass) in
        guard let user = user, let pass = pass else { return }
        self.canSubmit.value = !user.isEmpty && !pass.isEmpty
      }
    ).disposed(by: disposeBag)
  }

  func login() {
    router.goToDashboard()
  }
}
