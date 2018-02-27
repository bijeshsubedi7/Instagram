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
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        // Do any additional setup after loading the view.
        
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl){
        fetchStories()
        tableView.reloadData()
        refreshControl.endRefreshing()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.post = posts[indexPath.row]
        }
    }
    

}
