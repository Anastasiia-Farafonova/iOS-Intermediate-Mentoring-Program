//
//  UIView+extnsion.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 17.10.2021.
//

import UIKit

extension UIViewController {
  static func loadFromNib() -> UIViewController {
    let nib = UINib(nibName: String(describing: self), bundle: nil)
    return nib.instantiate(withOwner: nil, options: nil).first as? UIViewController ?? UIViewController()
  }
}
