//
//  CDRecipe+CoreDataClass.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import Foundation
import CoreData

fileprivate let componentsKeyPath = "components"

public class CDRecipe: NSManagedObject {
    var componentsList: DBComponents?
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        
        componentsList = DBComponents(with: self, keyPath: componentsKeyPath)
    }
    
    class func create(_ user: CDUser?) -> CDRecipe? {
        let recipe = CDRecipe.mr_createEntity()
        recipe?.user = user
        
        return recipe
    }
}
