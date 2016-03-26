//
//  ViewController.swift
//  FacebookIntegration
//
//  Created by Higher Visibility on 3/24/16.
//  Copyright © 2016 Higher Visibility. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var fbLoginBtn: FBSDKLoginButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFacebook()
       
        
    }
    
    
    //Delegate Method
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large)"]).startWithCompletionHandler { (connection, result, error) -> Void in
            
            print(result)
            
            let strFirstName = (result.objectForKey("first_name") as? String)!
            let strLastName = (result.objectForKey("last_name") as? String)!
            let strImageUrl = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            
            self.userName.text = "\(strFirstName) \(strLastName)"
            self.userImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strImageUrl)!)!)
        
        }
    
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        self.userImage.image = nil
        self.userName.text = "Label"
        
    }
    //facebook configuration
    func configureFacebook() {
     
        fbLoginBtn.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginBtn.delegate = self
        
    }


}

