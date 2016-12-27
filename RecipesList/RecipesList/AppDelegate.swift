//
//  AppDelegate.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/24/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit
import MagicalRecord

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
    
    func magicalRecordSetup() {
        MagicalRecord.enableShorthandMethods()
        MagicalRecord.setupCoreDataStack(withStoreNamed: "Resipes.store")
    }
    
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
    
    func save() {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore { (saved, error) in
            let saveError: NSError? = error as? NSError
            print("\(saveError), \(saveError?.userInfo)")
        }
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

