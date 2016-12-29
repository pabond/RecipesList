//
//  RecipeEditHeaderCell.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class RecipeEditHeaderCell: EditTableViewCell {
    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var recipeApplication: UITextField!
    @IBOutlet weak var companies: UITextField!

    //MARK: -
    //MARK: View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textFields = [recipeName, recipeApplication, companies]
    }
    
    //MARK: -
    //MARK: Interface Handling
    
    @IBAction func onAdd(_ sender: Any) {
        addFunction.map { $0() }
    }
    
    //MARK: -
    //MARK: Public Implementations
    
    override func fillWith(_ object: AnyObject?) {
        guard let recipe = object as? CDRecipe else { return }
        recipeName.text = recipe.recipeName
        recipeApplication.text = recipe.recipeApplications
        companies.text = recipe.recipeCompanies
    }
}
