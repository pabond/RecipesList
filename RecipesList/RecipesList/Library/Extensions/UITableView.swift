//
//  UITableView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

extension UITableView {
    func cellWithClass(_ cls: AnyClass) -> UITableViewCell {
        var cell: UITableViewCell?
        cell = self.dequeueReusableCell(withIdentifier: String(describing: cls.self))
        if (cell == nil) {
            cell = UINib.objectWithClass(cls) as? UITableViewCell
        }
        
        return cell!
    }
    
    func dequeueCellWithClass<T>(_ cls: T.Type, indexPath path: IndexPath) -> T {
        let clsString = String(describing: T.self)
        return self.dequeueReusableCell(withIdentifier: clsString, for: path) as! T
    }
    
    func registerCell(withClass cls: AnyClass?) {
        if let cls = cls {
            self.register(UINib.nibWithClass(cls), forCellReuseIdentifier: String(describing: cls.self))
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

