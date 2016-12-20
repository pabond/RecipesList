//
//  TableViewCell.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/9/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    var object: AnyObject? {
        didSet {
            fillWith(self.object)
        }
    }
    
    // method for overridding in subclasses
    func fillWith(_ object: AnyObject?) {
    }
}
