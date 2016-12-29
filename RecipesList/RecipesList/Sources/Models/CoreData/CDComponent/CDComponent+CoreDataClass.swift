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
        component.map({ $0.componentId() })
        
        return component
    }
    
    func componentId() {
        guard let recipeComponents = self.recipe?.components?.allObjects else { return }
        var identifier: Int64 = 0
        for component in recipeComponents {
            if let currentId = (component as? CDComponent)?.id {
                if currentId > identifier {
                    identifier = currentId
                }
            }
        }
        
        self.id = identifier + 1
    }
}
