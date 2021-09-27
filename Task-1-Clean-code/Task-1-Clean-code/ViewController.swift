//
//  ViewController.swift
//  Task-1-Clean-code
//
//  Created by Anastasiia Farafonova on 27.09.2021.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Demonstration of custom rules errors

        var bool = true

        if bool == true {
            print("bool")
        }

        // Demonstration of predefined rules errors

        let String = ""
        let x = 5
        bool = !bool
        let emptyString = ""

        if emptyString == "" { }
    }
}
