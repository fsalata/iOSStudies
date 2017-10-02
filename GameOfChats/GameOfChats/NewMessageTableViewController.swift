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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! UserCell
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        if let profileImageUrl = user.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

}

class UserCell: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textLabel?.frame = CGRect(x: 72, y: self.textLabel!.frame.origin.y - 2, width: self.textLabel!.frame.width, height: self.textLabel!.frame.height)
        self.detailTextLabel?.frame = CGRect(x: 72, y: self.detailTextLabel!.frame.origin.y + 2, width: self.detailTextLabel!.frame.width, height: self.detailTextLabel!.frame.height)
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 28
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(profileImageView)
        
        // profileImageView Constraints
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
