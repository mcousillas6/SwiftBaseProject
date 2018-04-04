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
  var userName = Variable<String?>(nil)
  var password = Variable<String?>(nil)
  var canSubmit = Variable<Bool>(false)
  var error = Variable<String?>(nil)

  init() {
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
    guard let username = userName.value, let password = password.value else { return }
    UserController.sharedInstance.login(with: username, password: password)
      .subscribe(
        onNext: { _ in
          AppRouter.sharedInstance.navigate(to: HomeRoute.dashboard, with: .reset)
        },
        onError: { [weak self] error in
          self?.error.value = error.localizedDescription
        }
      ).disposed(by: disposeBag)
  }
}
