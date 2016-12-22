//
//  CalculateValueCell.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class CalculateValueCell: RecipeDetailCell {
    @IBOutlet weak var countTextField: UITextField!
    var calculateFunction: ((_ textField: UITextField) -> ())?
    
    override func fillWith(_ object: AnyObject?) {
        if let recipe = object as? Recipe {
            let weight = recipe.weight
            countTextField.text = "\(weight)"
        }
    }
    
    @IBAction func onCalculate(_ sender: Any) {
        calculateFunction.map({ $0(countTextField) })
    }
}
