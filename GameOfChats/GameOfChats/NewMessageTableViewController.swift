//
//  NewMessageTableViewController.swift
//  GameOfChats
//
//  Created by Fábio Salata on 25/07/17.
//  Copyright © 2017 Fábio Salata. All rights reserved.
//

import UIKit
import Firebase

class NewMessageTableViewController: UITableViewController {
    
    var users = [User]()
    
    let cellID = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.title = "New Message"
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellID)
        
        fetchUsers()
    }
    
    func fetchUsers() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : AnyObject]{
                let user = User()
                user.setValuesForKeys(dictionary)
                
                self.users.append(user)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }, withCancel: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

}

class UserCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
