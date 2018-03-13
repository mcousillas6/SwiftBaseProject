//
//  ServiceManager.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol ServiceManager {

  associatedtype ProviderType: TargetType

  var provider: MoyaProvider<ProviderType> { get }

}

class BaseManager<T>: ServiceManager where T: TargetType {

  typealias ProviderType = T

  private var sharedProvider: MoyaProvider<T>!

  var provider: MoyaProvider<T> {
    guard let provider = sharedProvider else {
      self.sharedProvider = MoyaProvider<T>()
      return sharedProvider
    }
    return provider
  }

}
