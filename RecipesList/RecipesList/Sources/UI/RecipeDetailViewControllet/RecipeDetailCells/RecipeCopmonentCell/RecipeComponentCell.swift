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

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func fillWith(_ object: AnyObject?) {
        guard let component = object as? CDComponent else { return }
        componentName.text = component.componentName
        componentDosage.text = "\(component.componentDosage)"
    }
}
