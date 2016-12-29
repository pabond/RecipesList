//
//  RecipeComponentEditCell.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class RecipeComponentEditCell : EditTableViewCell {
    @IBOutlet weak var componentName: UITextField!
    @IBOutlet weak var componentDosage: UITextField!
    
    //MARK: -
    //MARK: View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textFields = [componentName, componentDosage]
    }
    
    //MARK: -
    //MARK: Public Implementations
    
    override func fillWith(_ object: AnyObject?) {
        guard let component = object as? CDComponent else { return }
        componentName.text = component.componentName
        componentDosage.text = "\(component.componentDosage)"
    }
}
