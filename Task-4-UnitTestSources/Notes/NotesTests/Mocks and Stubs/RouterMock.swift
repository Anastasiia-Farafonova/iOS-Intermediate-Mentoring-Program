//
//  RouterMock.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 28.11.2021.
//

import UIKit
@testable import Notes

class RouterMock: RouterProtocol {
    var viewControllerWasPushed = false
    var rootViewControllerWasSet = false
    
    func push(_ viewController: UIViewController) {
        viewControllerWasPushed = true
    }
    
    func setRootController(_ viewController: UIViewController) {
        rootViewControllerWasSet = true
    }
}
