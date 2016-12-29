//
//  OneIndexArrayChange.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class OneIndexArrayChange: ArrayChange {
    var indexPath: IndexPath?
    var tIndexPath: IndexPath {
        get {
            return IndexPath(row: ((indexPath?.row) ?? 0) + 1, section: (indexPath?.section) ?? 0)
        }
    }
    
    init(_ indexPath: IndexPath?) {
        super.init()
        
        self.indexPath = indexPath
    }
}
