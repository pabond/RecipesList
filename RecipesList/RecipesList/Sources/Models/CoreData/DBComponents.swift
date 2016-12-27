//
//  DBComponents.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

fileprivate let entityesName = "CDComponent"
class DBComponents: DBArrayModel {
    override var entityName: String {
        get {
            return entityesName
        }
    }
    
    override var predicate: NSPredicate? {
        get {
            if keyPath != nil && self.object != nil {
                return NSPredicate(format: "object.userID == recipe.user.userID", argumentArray: [object as Any])
            }
            
            return super.predicate
        }
    }
    
    override var sortDesriptor: NSSortDescriptor {
        get { return NSSortDescriptor(key: "componentDosage", ascending: false) }
    }
}
