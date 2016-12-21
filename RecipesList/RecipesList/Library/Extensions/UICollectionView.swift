//
//  UICollectionView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/5/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

extension UICollectionView {
    func cellWithClass(_ cls: AnyClass, for indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: cls.self), for: indexPath)
            if (cell == nil) {
                cell = UINib.objectWithClass(cls) as? UICollectionViewCell
            }
    
        return cell!
    }

    func registerCell(withClass cls: AnyClass?) {
        if let cls = cls {
            self.register(UINib.nibWithClass(cls), forCellWithReuseIdentifier: String(describing: cls.self))
        }
    }
    
    func registerCells(withClasses classes: [AnyClass]?) {
        if classes == nil {
            return
        }
        
        for cls in classes! {
            self.registerCell(withClass: cls)
        }
    }
}
