//
//  ViewController.swift
//  CircularLoading
//
//  Created by Fábio Salata on 30/01/18.
//  Copyright © 2018 Bin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    
    let countLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        let path = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true);
        
        let trackLayer = CAShapeLayer()
        
        trackLayer.path = path.cgPath
        
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.red.withAlphaComponent(0.3).cgColor
        trackLayer.lineWidth = 10
        trackLayer.lineCap = kCALineCapRound
        
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = path.cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = kCALineCapRound
        
        view.layer.addSublayer(shapeLayer)
        
        countLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        countLabel.textAlignment = NSTextAlignment.center
        countLabel.center = view.center
        countLabel.textColor = UIColor.red
        countLabel.font = UIFont(name: countLabel.font.fontName, size: 36)
        countLabel.text = "0%"
        
        view.addSubview(countLabel)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    let animationDuration = 0.5
    var seconds = 0
    @objc private func handleTap() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = animationDuration
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "myAnimation")
    }

}

