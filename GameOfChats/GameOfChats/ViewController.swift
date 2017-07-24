//
//  ViewController.swift
//  GameOfChats
//
//  Created by Fábio Salata on 24/07/17.
//  Copyright © 2017 Fábio Salata. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    func handleLogout () {
        let loginViewController = LoginViewController()
        
        present(loginViewController, animated: true, completion: nil)
    }
}

