//
//  CalculatedRecipe.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

fileprivate let maxPercent: Float = 100

class CalculatedRecipe: NSObject {
    var components = [RecipeComponent]()
    var recipe: Recipe?
    var count: Float? {
        get {
            var currentCount: Float = 0
            components.forEach({ currentCount += $0.componentDosage! })
            return currentCount
        }
    }

    func fillWithRecipe(_ recipe: Recipe) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.recipe = recipe
            let recipeWeight = recipe.weight
            recipe.components.models.forEach({ [weak self] in
                let currentComponent = $0 as? RecipeComponent
                let component = RecipeComponent()
                component.componentName = currentComponent?.componentName
                let dosage = currentComponent?.componentDosage
                component.componentDosage = dosage
                component.percentageInRecipe = dosage! * maxPercent / recipeWeight
                
                self?.components.append(component)
            })
        }
    }
    
    func applyToWeight(_ recipeWeight: Float) {
        components.forEach({
            if let percent = $0.percentageInRecipe {
                $0.componentDosage = recipeWeight * percent / maxPercent
            }
        })
    }
}
