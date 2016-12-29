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
    
    //MARK: -
    //MARK: View lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: -
    //MARK: Public Implementations
    
    func fill(with object: AnyObject?) {
        guard let recipe = object as? CDRecipe else { return }
        
        recipeName.text = recipe.recipeName
        recipeApplication.text = recipe.recipeApplications
        companies.text = recipe.recipeCompanies
    }
}
