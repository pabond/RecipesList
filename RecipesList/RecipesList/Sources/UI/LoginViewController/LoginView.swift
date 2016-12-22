//
//  LoginView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

let animationDuration = 1.5
let lowerAlpha: CGFloat = 0
let upperAlpha: CGFloat = 1

class LoginView: UIView {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    var user: GIDGoogleUser? {
        get {
            return GIDSignIn.sharedInstance().currentUser
        }
    }
    
    var authorizedText: String? {
        guard let userName = user?.profile.givenName else { return nil }
        
        return "Welcome, " + userName
    }
    let unauthorizedText = "Please SignIn to continue"
    var isSignedIn: Bool = false {
        didSet {
            _ = subviews.flatMap { $0.alpha = lowerAlpha }
            
            if isSignedIn {
                loadAvatarImage()
            }
            
            continueButton.isHidden = !isSignedIn
            logOutButton.isHidden = !isSignedIn
            signInButton.isHidden = isSignedIn
            welcomeLabel.isHidden = false
            welcomeLabel.text = isSignedIn ? authorizedText : unauthorizedText
            
            UIView.animate(withDuration: animationDuration, animations: { [weak self] in
                _ = self?.subviews.flatMap { $0.alpha = upperAlpha }
            })
        }
    }
    
    func loadAvatarImage() {
        DispatchQueue.global(qos: .background).async { [weak self] () -> Void in
            let data:NSData? = NSData(contentsOf : (self?.user?.profile.imageURL(withDimension: 300))!)
            DispatchQueue.main.async { () -> Void in
                self?.avatarImageView.image = UIImage(data : data as! Data)
                self?.avatarImageView.isHidden = false
                UIView.animate(withDuration: animationDuration, animations: {
                    self?.avatarImageView.alpha = upperAlpha
                })
            }
        }
    }
}
