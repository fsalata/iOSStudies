//
//  ViewController.swift
//  GameOfChats
//
//  Created by Fábio Salata on 24/07/17.
//  Copyright © 2017 Fábio Salata. All rights reserved.
//

import UIKit
import Firebase

class MessagesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       checkIfLoggedIn()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleNewMessage))
    }
    
    func checkIfLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        else {
            let uid = Auth.auth().currentUser?.uid
            
            Database.database().reference().child("users").child(uid!).observe(DataEventType.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    self.navigationItem.title = dictionary["name"] as? String
                }
            }, withCancel: nil)
        }
    }
    
    func handleNewMessage() {
        let newMessageViewController = NewMessageTableViewController()
        let navigationController = UINavigationController(rootViewController: newMessageViewController)
        present(navigationController, animated: true, completion: nil)
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

