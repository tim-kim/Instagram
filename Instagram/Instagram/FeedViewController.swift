//
//  FeedViewController.swift
//  Instagram
//
//  Created by Tim Kim on 3/13/17.
//  Copyright © 2017 Tim Kim. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user: PFUser?
    var posts: [PFObject]?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        

        
        self.user = PFUser.current()
        if (user?["postid"] != nil) {
            self.appendData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.user = PFUser.current()
        if (user?["postid"] != nil) {
            self.appendData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func appendData(){
        let query = PFQuery(className: "PhotoPost")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.whereKey("user", equalTo: self.user!)
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error != nil {
                print("ERROR: data retrieval failed")
            } else {
                print("yes nice cool")
                if let objects = objects {
                    self.posts = objects
                    OperationQueue.main.addOperation(){
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if posts == nil {
            return 0
        } else {
            return posts!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        if let post = posts?[indexPath.row] {
            cell.captionLabel.text = post["text"] as! String?
            if let imageData = post["image"] {
                let image = UIImage(data: (imageData as! NSData) as Data)
                cell.postImageView.image = image
            }
        }
        return cell
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if error != nil {
                print("error")
            } else {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }

}
