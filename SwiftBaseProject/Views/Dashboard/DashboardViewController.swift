//
//  DashboardViewController.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class DashaboardViewController: UIViewController {

  @IBOutlet weak var logoutBtn: UIButton!
  @IBOutlet weak var nameLabel: UILabel!

  var viewModel: DashboardViewModel!
  private var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  func setup() {
    viewModel.user.asObservable().subscribe(
      onNext: { [unowned self] user in
        guard let user = user else { return }
        self.nameLabel.text = user.email
      }
    ).disposed(by: disposeBag)

    logoutBtn.addTarget(self, action: #selector(logout), for: .touchUpInside)
  }

  @objc
  func logout() {
    viewModel.logout()
  }

}
