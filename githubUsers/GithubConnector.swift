//
//  GithubConnector.swift
//  githubUsers
//
//  Created by Lesha on 19.07.16.
//  Copyright © 2016 Lesha. All rights reserved.
//

import Foundation
import UIKit

var JSONData = NSMutableData()

class GithubConnector
{
    func getGithubUsers(count:Int) -> Array<GithubUser>!
    {
        let url = NSURL(string: "https://api.github.com/users")
        let data = NSData(contentsOfURL: url!)
        if data == nil
        {
            return Array();
        }
        var arrayToReturn = Array<GithubUser>()
        do {
            let objects = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            for i in 0...objects.count - 1
            {
                if i >= count
                {
                    break;
                }
                let githubUser = GithubUser();
                githubUser.login = objects[i]["login"] as? String;
                if objects[i]["avatar_url"] != nil {
                    let url = NSURL(string: objects[i]["avatar_url"] as! String)
                    if let data = NSData(contentsOfURL: url!) {
                        githubUser.avatar = UIImage(data: data)
                    }        
                }
                githubUser.profileLink = objects[i]["url"] as? String;
                arrayToReturn.append(githubUser);
            }
        } catch {
            // Handle Error
        }
        
        return arrayToReturn;
    }
}