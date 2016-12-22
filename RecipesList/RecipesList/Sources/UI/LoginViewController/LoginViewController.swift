//
//  LoginViewController.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    var loginView: LoginView?
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        GIDSignIn.sharedInstance().delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = viewGetter()
        
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
            loginView?.isSignedIn = error == nil
    }
}
