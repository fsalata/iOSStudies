//
//  ViewModel.swift
//  ColourfulBall
//
//  Created by Fabio Salata on 17/07/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import ChameleonFramework
import Foundation
import RxSwift
import RxCocoa

class CircleViewModel {
    
    var centerVariable = Variable<CGPoint?>(.zero)
    var backgroundColorObservable: Observable<UIColor>!
    
    init() {
        setup()
    }
    
    func setup() {
        backgroundColorObservable = centerVariable.asObservable()
            .map {center in
                guard let center = center else {return UIColor.black.flatten()}
                
                let red: CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255.0)) / 255.0
                let green: CGFloat = 0.0
                let blue: CGFloat = 0.0
                
                return UIColor.flatten(UIColor(red: red, green:green, blue:blue, alpha: 1.0))()
            }
    }
    
}

