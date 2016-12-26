//
//  LoginViewController.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class LoginViewController: ViewController, GIDSignInUIDelegate {
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
            guard let navigationVC = segue.destination as? UINavigationController else { return }
            guard let recipesVC = navigationVC.viewControllers.first as? RecipesViewController else { return }
            guard let user = sender as? GIDGoogleUser else { return }
            recipesVC.user = CDUser.user(with: user)
        }
    }
}

extension LoginViewController : GIDSignInDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            loginView?.isSignedIn = error == nil
    }
}
