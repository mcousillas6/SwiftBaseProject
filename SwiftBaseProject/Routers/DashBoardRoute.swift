//
//  DashBoardRoute.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 4/4/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import UIKit

enum HomeRoute: Route {
  case dashboard

  var screen: UIViewController {
    switch self {
    case .dashboard:
      guard let dashboard = R.storyboard.dashboard.instantiateInitialViewController() else {
        return UIViewController()
      }
      dashboard.viewModel = DashboardViewModel()
      return dashboard
    }
  }
}
