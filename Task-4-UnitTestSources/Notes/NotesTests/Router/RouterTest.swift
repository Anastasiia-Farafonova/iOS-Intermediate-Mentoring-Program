//
//  RouterTest.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 28.11.2021.
//

import XCTest
@testable import Notes

class RouterTest: XCTestCase {
    var router: Router!
    var navigationViewController: UINavigationController!
    
    override func setUpWithError() throws {
        navigationViewController = UINavigationController()
        router = Router(rootViewController: navigationViewController)
    }

    override func tearDownWithError() throws {
        router = nil
        navigationViewController = nil
    }
    
    func testViewControllerWasPushed() {
        let viewController = UIViewController()
        
        router.push(viewController)
        
        XCTAssertEqual(navigationViewController.topViewController, viewController)
    }
    
    func testRootControllerWasSet() {
        let viewController = UIViewController()
        
        router.setRootController(viewController)
        XCTAssertEqual(navigationViewController.viewControllers.first, viewController)
    }
}
