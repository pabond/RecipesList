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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        textFields = [recipeName, recipeApplication, companies]
    }
    
    @IBAction func onAdd(_ sender: Any) {
        addFunction.map { $0() }
    }
    
    override func fillWith(_ object: AnyObject?) {
        guard let recipe = object as? Recipe else { return }
        recipeName.text = recipe.name
        recipeApplication.text = recipe.applications
        companies.text = recipe.companies
    }
}
