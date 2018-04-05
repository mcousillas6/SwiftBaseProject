//
//  BaseDataAccess.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/15/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

/**
 Public protocol that defines the minimum API that a DataAccess component should expose.

 The DataAccess is the component in charge of handling al databases requests for
 an specific Entity.

 Basic behaviour and configuration is provided by the BaseDataAccess class.
*/
public protocol DataAccess {
  /// The realm instance used to connect to the database
  var realm: Realm? { get }
  /// The realm configuration used to instantiate realm.
  var realmConfiguration: Realm.Configuration { get }
}

/**
 Base DataAccess class that implements generic behaviour to
 be extendended and used by subclassing it.

 This base implementation provides some basic configuration to conect to Realm.
 */
open class BaseDataAccess: DataAccess {
  open var disposeBag = DisposeBag()
  open let realmConfiguration = Realm.Configuration()

  open var realm: Realm? {
    guard let realm = try? Realm(configuration: realmConfiguration) else { return nil }
    return realm
  }
}
