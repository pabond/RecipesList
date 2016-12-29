//
//  RecipeComponentCell.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class RecipeComponentCell: RecipeDetailCell {
    @IBOutlet weak var componentName: UILabel!
    @IBOutlet weak var componentDosage: UILabel!
    
    //MARK: -
    //MARK: View lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: -
    //MARK: Public Implementations
    
    override func fillWith(_ object: AnyObject?) {
        if let component = object as? CDComponent {
            componentName.text = component.componentName
            componentDosage.text = "\(component.componentDosage)"
        } else if let component = object as? RecipeComponent {
            componentName.text = component.componentName
            componentDosage.text = "\(component.componentDosage!)"
        }
    }
}
