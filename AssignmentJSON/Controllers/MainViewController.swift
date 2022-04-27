//
//  MainViewController.swift
//  AssignmentJSON
//
//  Created by SAISURAJ on 4/27/22.
//  Copyright © 2022 SAISURAJ. All rights reserved.
//

import UIKit

var postsModelData = [PostsModel]()
class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource

{


    @IBOutlet weak var tblView: UITableView!
    
    var viewModelUser = PostsCommentsModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        viewModelUser.vc = self
        viewModelUser.postsDetails = true
        viewModelUser.getAllUserData()
    }
   
    func addSplashLoaderView() {
      if let customView = Bundle.main.loadNibNamed("SplashLoader", owner: self, options: nil)?.first as? SplashLoader {
            customView.frame = self.view.frame
            customView.tag   = 150
         self.view.addSubview(customView)
        }
    }
    
    func removeLoader() {
        let customView = self.view.viewWithTag(150)
        customView?.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelUser.arrPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as? PostsTableViewCell
         let modelPosts = viewModelUser.arrPosts[indexPath.row]
         cell?.modelPosts = modelPosts
         return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 100
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let CommentViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommentViewController") as! CommentViewController
         let modelPosts = viewModelUser.arrPosts[indexPath.row]
        CommentViewController.modelPosts = modelPosts.id
    self.navigationController?.pushViewController(CommentViewController, animated: true)
    }

}
