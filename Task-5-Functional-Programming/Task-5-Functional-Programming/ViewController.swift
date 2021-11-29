//
//  ViewController.swift
//  Task-5-Functional-Programming
//
//  Created by Anastasiia Farafonova on 29.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(doubled(arr: [1, 2, 3]))
        print(summation(num: 8))
        print(findSum(num: 8))
        print(findSum(num: 10))
        print(dontGiveMeFive(1, 9))
        print(dontGiveMeFive(4, 17))
    }
    
    func doubled(arr: [Int]) -> [Int] {
        return arr.map { $0 * 2 }
    }

    func summation(num: Int) -> Int {
        return (0...num).reduce(0, +)
    }

    func findSum(num: Int) -> Int {
        return (0...num).filter { $0 % 3 == 0 || $0 % 5 == 0 }.reduce(0, +)
    }

    func dontGiveMeFive(_ start: Int, _ end: Int) -> Int {
        return (start...end).filter { !String($0).contains("5") }.count
    }
}
