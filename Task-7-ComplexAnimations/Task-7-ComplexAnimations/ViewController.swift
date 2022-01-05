//
//  ViewController.swift
//  Task-7-ComplexAnimations
//
//  Created by Anastasiia Farafonova on 02.01.2022.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    private var images: [UIImageView] = []
    
    private enum Const {
        static let snowflakeImageName = "snowflake.png"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSnowflakes(count: 100, sizeRange: (20, 50), alphaRange: (0.3, 1))
        startSnowAnimation()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            dissolveSnowflakes()
        }
    }
    
    private func createSnowflakes(count: Int, sizeRange: (CGFloat, CGFloat), alphaRange: (CGFloat, CGFloat)) {
        for _ in 0..<count {
            let image = UIImage(named: Const.snowflakeImageName)
            let imageView = UIImageView(image: image)
            let randomSize = CGFloat.random(in: sizeRange.0...sizeRange.1)
            let randomX = CGFloat.random(in: view.bounds.minX...view.bounds.maxX)
            imageView.frame = CGRect(x: randomX, y: -randomSize, width: randomSize, height: randomSize)
            imageView.alpha = CGFloat.random(in: alphaRange.0...alphaRange.1)
            
            images.append(imageView)
            view.addSubview(imageView)
        }
    }
    
    private func startSnowAnimation() {
        for element in images {
            var transform = CATransform3DIdentity
            let transformByX = CGFloat.random(in: -50...50)
            let transformByY = view.bounds.height - 10
            transform = CATransform3DTranslate(transform, transformByX, transformByY, 0)
            
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = CATransform3DIdentity
            animation.toValue = transform
            animation.duration = CGFloat.random(in: 3...7)
            animation.beginTime = CACurrentMediaTime() + CGFloat.random(in: 0...3)
            animation.fillMode = .backwards
            
            element.layer.transform = transform
            element.layer.add(animation, forKey: nil)
        }
    }
    
    private func dissolveSnowflakes() {
        for element in images {
            UIView.animate(withDuration: CGFloat.random(in: 1...3)) {
                element.alpha = 0.0
            }
        }
    }
}
