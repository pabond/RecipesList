//
//  CalculatedRecipe.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit
import RxSwift

fileprivate let maxPercent: Float = 100

class CalculatedRecipe: NSObject {
    var components = [RecipeComponent]()
    var recipe: CDRecipe?
    var count: Float? {
        get {
            var currentCount: Float = 0
            components.forEach({ currentCount += $0.componentDosage! })
            return currentCount
        }
    }
    
    var weight: Float {
        get {
            var count: Float = 0
            components.forEach({ _ = $0.componentDosage.map({ count += $0 }) })
            
            return count
        }
    }

    func fillWithRecipe(_ recipe: CDRecipe) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.recipe = recipe
            recipe.components?.allObjects.forEach({ [weak self] in
                let currentComponent = $0 as? RecipeComponent
                let component = RecipeComponent()
                component.componentName = currentComponent?.componentName
                component.componentDosage = currentComponent?.componentDosage
                
                self?.components.append(component)
            })
            
            self?.addPercentage()
        }
    }
    
    func addPercentage() {
        let recipeWeight = weight
        components.forEach({
            var percentage: Float = 0
            if let dosage = $0.componentDosage {
                percentage = dosage * maxPercent / recipeWeight
            } else {
                percentage = 0
            }
            
            $0.percentageInRecipe = percentage
        })
        
    }
    
    func applyToWeight(_ recipeWeight: Float) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            self?.components.forEach({
                if let percent = $0.percentageInRecipe {
                    $0.componentDosage = recipeWeight * percent / maxPercent
                }
            })
            observer.on(.completed)
            return Disposables.create()
        }
    }
}
