//
//  CircularTransition.swift
//  Circular Transition
//
//  Created by Fábio Salata on 09/05/18.
//  Copyright © 2018 Bin. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {

    var circle = UIView()
    
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.white
    
    var duration = 0.5
    
    enum CircularTransitionMode:Int {
        case present, dismiss, pop
    }
    
    var transitionMode: CircularTransitionMode = .present
    
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                
                circle = UIView()
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.width / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                
                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                
                containerView.addSubview(presentedView)
                
                
                UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.circle.transform = CGAffineTransform.identity
                        presentedView.transform = CGAffineTransform.identity
                        presentedView.alpha = 1
                        presentedView.center = viewCenter
                    }, completion: { (success: Bool) in
                        transitionContext.completeTransition(success)
                })
            }
        }
        else {
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.width / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                    
                }, completion: {(success: Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    
                    self.circle.removeFromSuperview()
                    
                    transitionContext.completeTransition(success)
                })
                
            }
        }
    }
    
    func frameForCircle(withViewCenter viewCenter: CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect {
        let xLength = fmax(startingPoint.x, viewSize.width - startingPoint.x)
        let yLength = fmax(startingPoint.y, viewSize.height - startingPoint.y)
        
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
}
