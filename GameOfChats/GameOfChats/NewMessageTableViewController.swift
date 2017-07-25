//
//  NewMessageTableViewController.swift
//  GameOfChats
//
//  Created by Fábio Salata on 25/07/17.
//  Copyright © 2017 Fábio Salata. All rights reserved.
//

import UIKit

class NewMessageTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.title = "New Message"
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

}
