//
//  StoryViewController.swift
//  Instagram
//
//  Created by Bijesh Subedi on 2/25/18.
//  Copyright © 2018 Bijesh Subedi. All rights reserved.
//

import UIKit
import Parse

class StoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts: [Post] = []

    @IBOutlet weak var tableView: UITableView!
    @IBAction func didLogOut(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 300
        fetchStories()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchStories(){
        let query = Post.query()!
        query.order(byDescending: "createdAt")
        query.limit = 20
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            self.posts = (posts as! [Post])
            if (posts != nil) {
                print("Images are fetched")
            } else {
                print ("Error while fetching data")
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath) as! storyCell
        cell.post = posts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    

}
