//
//  Constants.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation

struct Constants {
  // Sample env management
  #if STAGING
    static let apiBaseUrl = URL(string: "https://google.com")!
  #else
    static let apiBaseUrl = URL(string: "point_to_prod_here")!
  #endif
}
