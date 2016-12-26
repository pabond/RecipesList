//
//  CDComponent+CoreDataClass.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import Foundation
import CoreData

public class CDComponent: NSManagedObject {
    
    class func create(_ recipe: CDRecipe?) -> CDComponent? {
        let component = CDComponent.mr_createEntity()
        component?.recipe = recipe
        
        return component
    }
}
