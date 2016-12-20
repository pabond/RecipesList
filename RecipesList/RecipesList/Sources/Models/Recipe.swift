//
//  Recipe.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/2/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class Recipe: Model {
    var name: String?
    var applications = String()
    var components = Components()
    var companies = String()
    
    var weight: Float {
        get {
            var count: Float = 0
            components.models.forEach({ _ = ($0 as? RecipeComponent)?.componentDosage.map({ count += $0 }) })
            
            return count
        }
    }
    
    func addComponent(_ component: RecipeComponent?) {
        components.addModel(component)
    }
    
    func removeComponent(_ component: RecipeComponent?) {
        components.removeModel(component)
    }
    
    func removeComponentAtIndex(_ index: Int?) {
        components.removeModelAtIndex(index)
    }
    
    func componentAtIndex(_ index: Int?) -> RecipeComponent? {
        return (components.model(at: index) as? RecipeComponent?) ?? nil
    }
}
