//
//  HomeViewController.swift
//  guntagram
//
//  Created by Ali Sutcu on 21.12.2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var postsTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    let fetchManager = PostFetchManager()
    let updateManager = PostUpdateManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        postsTableView.addSubview(refreshControl) // not required when using UITableViewController
        self.tabBarController?.navigationItem.hidesBackButton = true
        fetchManager.delegate = self
        updateManager.delegate = self
        fetchManager.fetchNewPosts()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        fetchManager.fetchNewPosts()
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchManager.getPostCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! PostTableViewCell
        cell.postObject = fetchManager.getPostAtIndex(index: indexPath.row)
        cell.updateFields()
        
        cell.likePressedCallback = {
            self.updateManager.changeLikeCount(post: cell.postObject!)
            cell.updateFields()
            // TODO: decrease like count if there is an error
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let post = fetchManager.getPostAtIndex(index: indexPath.row) {
            let image = post.uiImage
            let myImageWidth = image.size.width
            let myImageHeight = image.size.height
            let myViewWidth = self.view.frame.size.width
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            return scaledHeight + 95
        }
        return 0
    }
}

extension HomeViewController: PostFetchManagerProtocol {
    func postLoaded() {
        self.postsTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
}

extension HomeViewController: PostUpdateManagerProtocol {
    func updateFailed(error: Error) {
        print(error)
    }
}
