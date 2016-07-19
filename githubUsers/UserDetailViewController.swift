//
//  UsersDetailViewController.swift
//  githubUsers
//
//  Created by Lesha on 19.07.16.
//  Copyright © 2016 Lesha. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController
{
    var avatarImage:UIImage?;
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);
        avatarImageView.image = avatarImage;
    }
}
