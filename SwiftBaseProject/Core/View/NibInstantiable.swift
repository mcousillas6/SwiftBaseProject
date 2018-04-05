//
//  NibInstantiable.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 4/5/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import UIKit

/**
 UIView subclass that can be used to compose views using xibs.

 The main goal is to be able to avoid the issues that come when
 using custom views that are made in isolated xibs inside other xibs.
 This class handles all the necessary things to get you up and running
 with a view that instantiates itself propperly, wiring up all IBOutlets
 and actions automatically.

 # Usage:
 - Create your NibInstantiableView subclass as you always do with any custom view.
 - **IMPORTANT** set your xib'x FileOwner to that swift file.
 - Now you can go to another xib(or storyboard), throw a plain UIView inside and set it's class to
 your new custom view, it will inject the corresponding xib as if it wasn't created separately.
*/
open class NibInstantiableView: UIView {
  open var contentView: UIView!

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupContentView()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupContentView()
  }

  /**
   Customization point for your view, this is called AFTER the
   view is instantiated, so you have access to every outlet set up on the xib.
  */
  open func viewSetup() {
    assertionFailure("You need to override this method and add any customization needed for your content view")
  }

  /**
   Loads the corresponding view from a nib file.

   By default, it searches for a nib with the exact same name as
   the class that you are using, you can override this method if
   you are going to instantiate it from another source.

   ** Please note that the view that you are instantiating has to
   have its FILE OWNER set to be the file of the corresponding class
   otherwise, it will crash and burn in a horrible way **.
  */
  open func loadView() -> UIView? {
    let nibName = String(describing: self)
    guard
      let view = UINib(nibName: nibName, bundle: nil)
        .instantiate(withOwner: nil, options: nil)
        .first as? UIView
    else {
      assertionFailure(
        "Could not init content view from xib named \(nibName), please override this method and instantiate the correct view"
      )
      return nil
    }
    return view
  }

  private func setupContentView() {
    contentView = loadView()
    setContentViewSize()
    addSubview(contentView)
    backgroundColor = .clear
    viewSetup()
  }

  private func setContentViewSize() {
    contentView.frame = bounds
    contentView.clipsToBounds = false
    contentView.translatesAutoresizingMaskIntoConstraints = true
    contentView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
  }
}
