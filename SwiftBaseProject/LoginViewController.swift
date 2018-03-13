//
//  ViewController.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

  @IBOutlet weak var userNameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var loginBtn: UIButton!
  var viewModel: LoginViewModel!
  private var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  func setup() {
    userNameField.rx
      .text
      .bind(to: viewModel.userName)
      .disposed(by: disposeBag)
    passwordField.rx
      .text
      .bind(to: viewModel.password)
      .disposed(by: disposeBag)
    viewModel.canSubmit.asObservable().subscribe(
      onNext: { [unowned self] canSubmit in
        self.loginBtn.isEnabled = canSubmit
      }
    ).disposed(by: disposeBag)
    loginBtn.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
  }

  @objc func loginTapped() {
    viewModel.login()
  }

}
