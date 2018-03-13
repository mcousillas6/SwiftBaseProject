//
//  TargetType+Base.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import Moya

protocol BaseTargetType {

}

extension TargetType {

  var baseURL: URL { return Constants.apiBaseUrl }

  var sampleData: Data { return Data() }

}
