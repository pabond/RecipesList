//
//  LoginViewController.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

let animationDuration = 1.5
let lowerAlpha: CGFloat = 0
let upperAlpha: CGFloat = 1

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signInButton: GIDSignInButton!
    var isSignedIn: Bool? {
        didSet {
            let value = isSignedIn
            _ = view.subviews.flatMap { $0.alpha = lowerAlpha }
            
            continueButton.isHidden = !value!
            logOutButton.isHidden = !value!
            signInButton.isHidden = value!
            welcomeLabel.isHidden = false

            UIView.animate(withDuration: animationDuration, animations: {
                _ = self.view.subviews.flatMap { $0.alpha = upperAlpha }
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        GIDSignIn.sharedInstance().delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    @IBAction func onContinue(_ sender: Any) {
        showUserRecipes(GIDSignIn.sharedInstance().currentUser)
    }
    
    func showUserRecipes(_ user: GIDGoogleUser!) {
        performSegue(toViewControllerWithClass: RecipesViewController.self, sender: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: RecipesViewController.self) {
            guard let recipesVC = segue.destination as? RecipesViewController else { return }
            //recipesVC.recipes = user.recipes?
        }
    }
}

extension LoginViewController : GIDSignInDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            isSignedIn = true
            welcomeLabel.text = "Welcome, " + user.profile.givenName
            DispatchQueue.global(qos: .background).async { [weak self] () -> Void in
                let data:NSData? = NSData(contentsOf : user.profile.imageURL(withDimension: 300))
                DispatchQueue.main.async { () -> Void in
                    self?.avatarImageView.image = UIImage(data : data as! Data)
                    self?.avatarImageView.isHidden = false
                    UIView.animate(withDuration: animationDuration, animations: {
                        self?.avatarImageView.alpha = upperAlpha
                    })
                }
            }
        } else {
            print("\(error.localizedDescription)")
            isSignedIn = false
            welcomeLabel.text = "Please SignIn to continue"
        }
    }
}
