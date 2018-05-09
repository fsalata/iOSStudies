//
//  MenuButton.swift
//  Circular Transition
//
//  Created by Fábio Salata on 09/05/18.
//  Copyright © 2018 Bin. All rights reserved.
//

import UIKit

@IBDesignable class MenuButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupButton()
    }
    
    override func prepareForInterfaceBuilder() {
        setupButton()
    }
    
    func setupButton() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        
//        let blurEffect = UIBlurEffect(style: .regular)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.bounds
//        blurEffectView.isUserInteractionEnabled = false
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//        self.addSubview(blurEffectView)
    }
}
