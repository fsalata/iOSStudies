//
//  ViewController.swift
//  GameOfChats
//
//  Created by Fábio Salata on 24/07/17.
//  Copyright © 2017 Fábio Salata. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    func handleLogout () {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginViewController = LoginViewController()
        present(loginViewController, animated: true, completion: nil)
    }
}

