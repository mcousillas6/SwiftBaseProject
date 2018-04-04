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

  required init() {
  }

  var provider: MoyaProvider<T> {
    guard let provider = sharedProvider else {
      self.sharedProvider = MoyaProvider<T>(
        plugins: [
          NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)
        ]
      )
      return sharedProvider
    }
    return provider
  }

  func request<T>(_ target: ProviderType, at keyPath: String? = nil) -> Observable<T> where T: Codable {
    return provider.rx.request(target)
      .filterSuccessfulStatusCodes()
      .map(T.self, atKeyPath: keyPath, using: JSONDecoder())
      .asObservable()
  }

  func requestCollection<T>(_ target: ProviderType, at keyPath: String? = nil) -> Observable<[T]> where T: Codable {
    return provider.rx.request(target)
      .filterSuccessfulStatusCodes()
      .map([T].self, atKeyPath: keyPath, using: JSONDecoder())
      .asObservable()
  }

  private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
      let dataAsJSON = try JSONSerialization.jsonObject(with: data)
      let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
      return prettyData
    } catch {
      return data
    }
  }

}
