//
//  AppDelegate + MagicalRecord.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//


import MagicalRecord

extension AppDelegate {
    func magicalRecordSetup() {
        MagicalRecord.enableShorthandMethods()
        MagicalRecord.setupCoreDataStack(withStoreNamed: "Resipes.store")
    }
    
    func save() {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore { (saved, error) in
            let saveError: NSError? = error as? NSError
            print("\(saveError), \(saveError?.userInfo)")
        }
    }
}
