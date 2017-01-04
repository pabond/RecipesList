//
//  TwoIndexArrayChange.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class TwoIndexArrayChange: OneIndexArrayChange {
    var toIndexPath: IndexPath?
    
    init(_ indexPath: IndexPath?, with toIndexPath: IndexPath?) {
        super.init(indexPath)
        
        self.toIndexPath = toIndexPath
    }
}
