//
//  UIView+ConstraintsHelpers.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 4/5/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import UIKit

/**
 UIView extension to provide helper methods to handle NSLayoutConstraints programatically.
 All functions return self to provide function chaining so you can do things like:
    view.equalWidth(to: view1).equalHeight(to: view2)
*/
public extension UIView {
  /// Attaches a view to another, using it as a container using LayoutConstraints.
  public func attach(to container: UIView, topMargin: CGFloat = 0.0, rightMargin: CGFloat = 0.0, bottomMargin: CGFloat = 0.0, leftMargin: CGFloat = 0.0) -> UIView {
    translatesAutoresizingMaskIntoConstraints = false
    let constraints = [
      NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: container, attribute: .width, multiplier: 1.0, constant: -(rightMargin + leftMargin)),
      NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: container, attribute: .height, multiplier: 1.0, constant: -(topMargin + bottomMargin)),
      NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1.0, constant: 0.0)
    ]
    NSLayoutConstraint.activate(constraints)
    return self
  }

  /// Centers a view inside a container.
  public func center(in container: UIView, verticalOffset: CGFloat = 0.0, horizontalOffset: CGFloat = 0.0) -> UIView {
    let constraints = [
      NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1.0, constant: horizontalOffset),
      NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1.0, constant: verticalOffset)
    ]
    NSLayoutConstraint.activate(constraints)
    return self
  }

  /// Aligns the view's top to it's container top margin
  public func pinToTop(to container: UIView, offset: CGFloat = 0.0) -> UIView {
    let constraints = [
      NSLayoutConstraint(item: self, attribute: .topMargin, relatedBy: .equal, toItem: container, attribute: .topMargin, multiplier: 1.0, constant: offset)
    ]
    NSLayoutConstraint.activate(constraints)
    return self
  }

  /// Aligns the view's left to it's container left margin
  public func pinToLeft(to container: UIView, offset: CGFloat = 0.0) -> UIView {
    let constraints = [
      NSLayoutConstraint(item: self, attribute: .leftMargin, relatedBy: .equal, toItem: container, attribute: .leftMargin, multiplier: 1.0, constant: offset)
    ]
    NSLayoutConstraint.activate(constraints)
    return self
  }

  /// Aligns the view's right to it's container right margin
  public func pinToRight(to container: UIView, offset: CGFloat = 0.0) -> UIView {
    let constraints = [
      NSLayoutConstraint(item: self, attribute: .rightMargin, relatedBy: .equal, toItem: container, attribute: .rightMargin, multiplier: 1.0, constant: offset)
    ]
    NSLayoutConstraint.activate(constraints)
    return self
  }

  /// Aligns the view's bottom to it's container bottom margin
  public func pinToBottom(to container: UIView, offset: CGFloat = 0.0) -> UIView {
    let constraints = [
      NSLayoutConstraint(item: self, attribute: .bottomMargin, relatedBy: .equal, toItem: container, attribute: .bottomMargin, multiplier: 1.0, constant: offset)
    ]
    NSLayoutConstraint.activate(constraints)
    return self
  }

  /// Set two views to have matching width
  public func equalWidth(to view: UIView, constant: CGFloat = 0.0) -> UIView {
    let constraints = [
      NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: constant)
    ]
    NSLayoutConstraint.activate(constraints)
    return self
  }

  /// Set two views to have matching height
  public func equalHeight(to view: UIView, constant: CGFloat = 0.0) -> UIView {
    let constraints = [
      NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: constant)
    ]
    NSLayoutConstraint.activate(constraints)
    return self
  }

  /// Aligns the view's leading to it's container leading margin
  public func alignLeading(with view: UIView, constant: CGFloat = 0.0) -> UIView {
    let constraints = [
      NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: constant)
    ]
    NSLayoutConstraint.activate(constraints)
    return self
  }

  /// Aligns the view's trailing to it's container trailing margin
  public func alignTrailing(with view: UIView, constant: CGFloat = 0.0) -> UIView {
    let constraints = [
      NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: constant)
    ]
    NSLayoutConstraint.activate(constraints)
    return self
  }
}
