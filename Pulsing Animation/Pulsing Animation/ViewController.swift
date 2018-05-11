//
//  ViewController.swift
//  Pulsing Animation
//
//  Created by Fábio Salata on 11/05/18.
//  Copyright © 2018 Bin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pulseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pulseButton.layer.cornerRadius = pulseButton.frame.width / 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addPulse(_ sender: Any) {
        let pulse = Pulsing(numberOfPulses: 1, radius: 110, position: pulseButton.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = pulseButton.backgroundColor?.cgColor
        
        self.view.layer.insertSublayer(pulse, below: pulseButton.layer)
    }
    
}

