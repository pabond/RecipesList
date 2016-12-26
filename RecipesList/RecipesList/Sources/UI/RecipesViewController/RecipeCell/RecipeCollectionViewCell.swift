//
//  RecipeCollectionViewCell.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/5/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeApplication: UILabel!
    @IBOutlet weak var companies: UILabel!
    var object: AnyObject? {
        didSet {
            fill(with: object)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fill(with object: AnyObject?) {
        guard let recipe = object as? CDRecipe else { return }
        
        recipeName.text = recipe.recipeName
        recipeApplication.text = recipe.recipeApplications
        companies.text = recipe.recipeCompanies
    }
}
