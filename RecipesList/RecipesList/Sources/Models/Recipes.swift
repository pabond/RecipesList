//
//  Recipes.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/2/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit
import CoreData

class Recipes: ArrayModel {
    override init() {
        super.init()
        models = [Recipe]()
    }
}
