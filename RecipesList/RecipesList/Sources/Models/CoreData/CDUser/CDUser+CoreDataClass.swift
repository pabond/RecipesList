//
//  CDUser+CoreDataClass.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/24/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

fileprivate let recipesKeyPath = "recipes"

public class CDUser: NSManagedObject {
    var recipesList: DBRecipes?
    
    class func user(with user: GIDGoogleUser) -> CDUser? {
        let dbUser: CDUser?
        guard let userID = user.userID else { return nil }
        let predicat = NSPredicate(format: "userID == %@", argumentArray: [userID])
        guard let users = CDUser.mr_findAll(with: predicat) as? [CDUser] else { return nil }
        if users.count > 0 {
            dbUser = users.first
        } else {
            dbUser = CDUser.mr_createEntity()
            dbUser?.userID = userID
            dbUser?.userName = user.profile.givenName
        }
        
        dbUser?.recipesList = DBRecipes(with: dbUser, keyPath: recipesKeyPath)
        
        return dbUser
    }
}
