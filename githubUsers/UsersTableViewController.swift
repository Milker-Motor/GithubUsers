//
//  UsersTableViewController.swift
//  githubUsers
//
//  Created by Lesha on 19.07.16.
//  Copyright © 2016 Lesha. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController
{
    var listOfUsers: [GithubUser] = [];
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);

        if listOfUsers.count == 0
        {
            updateView();
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listOfUsers.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UserTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserTableViewCell;
     
        cell.avatarImageView.image = listOfUsers[indexPath.row].avatar;
        cell.loginLabel.text = listOfUsers[indexPath.row].login;
        cell.profileLinkLabel.text = listOfUsers[indexPath.row].profileLink;
        
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "showUserDetail")
        {
            let userDetailViewController = (segue.destinationViewController as! UserDetailViewController)
            userDetailViewController.avatarImage = (sender as! UserTableViewCell).avatarImageView.image;
        }
    }
    
    func updateView() -> Void
    {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray);
        self.tableView.addSubview(activityIndicator);
        activityIndicator.center = self.tableView.center;
        activityIndicator.color = UIColor.blueColor();
        activityIndicator.startAnimating();
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let githubConnection = GithubConnector();
            self.listOfUsers = githubConnection.getGithubUsers(100)!;
            dispatch_async(dispatch_get_main_queue())
            {
                activityIndicator.stopAnimating();
                activityIndicator.removeFromSuperview();
                
                self.tableView.reloadData();
            }
        }
    }
}