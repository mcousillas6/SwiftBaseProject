//
//  AppRouter.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import UIKit

class AppRouter {

  var rootViewController: UIViewController?
  var window: UIWindow?

  func setupInitialViewController() -> UIViewController {
    guard let initialVC = R.storyboard.main.instantiateInitialViewController() else { return UIViewController() }
    initialVC.viewModel = LoginViewModel(router: self)
    let navigationController = UINavigationController(rootViewController: initialVC)
    rootViewController = navigationController
    return navigationController
  }

  func goToDashboard() {
    guard let dashboard = R.storyboard.dashboard.instantiateInitialViewController() else { return }
    dashboard.viewModel = DashboardViewModel(router: self)
    let navigationController = UINavigationController(rootViewController: dashboard)
    rootViewController = navigationController
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.window?.rootViewController = navigationController
    }
  }

  func logout() {
    guard let login = R.storyboard.main.instantiateInitialViewController() else { return }
    let navigationController = UINavigationController(rootViewController: login)
    rootViewController = navigationController
    login.viewModel = LoginViewModel(router: self)
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.window?.rootViewController = navigationController
    }
  }
}
