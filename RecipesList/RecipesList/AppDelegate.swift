//
//  AppDelegate.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/24/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        signInSetup()
        magicalRecordSetup()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        save()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        save()
    }
}

