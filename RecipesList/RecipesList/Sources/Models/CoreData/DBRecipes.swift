//
//  DBRecipes.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

fileprivate let entityesName = "CDRecipe"

class DBRecipes: DBArrayModel {
    override var entityName: String {
        get {
            return entityesName
        }
    }
    
    override var predicate: NSPredicate? {
        get {
            if keyPath != nil && self.object != nil {
                return NSPredicate(format: "user.userID == %@", argumentArray: [(object as! CDUser).userID!])
            }
            
            return super.predicate
        }
    }
    
    override var sortDescriptor: NSSortDescriptor {
        get { return NSSortDescriptor(key: "recipeName", ascending: false) }
    }
}
