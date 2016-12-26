//
//  RecipeDetailHeaderCell.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class RecipeDetailHeaderCell: RecipeDetailCell {
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeApplications: UILabel!
    @IBOutlet weak var recipeCompanies: UILabel!

    override func fillWith(_ object: AnyObject?) {
        guard let recipe = object as? CDRecipe else { return }
        recipeName.text = recipe.recipeName
        recipeApplications.text = recipe.recipeApplications
        recipeCompanies.text = recipe.recipeCompanies
    }
}
