//
//  AppDelegate + SignIn.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

extension AppDelegate {
    func signInSetup() {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        return GIDSignIn.sharedInstance()
            .handle(url,
                    sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                    annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
}
