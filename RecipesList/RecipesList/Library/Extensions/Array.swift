//
//  Array.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/1/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import Foundation

extension Array {
    mutating func move(from index: Int, to destIndex: Int) {
        let object = self[index]
        self.remove(at: index)
        self.insert(object, at: destIndex)
    }
    
    func objectWithClass(_ cls: AnyClass) -> AnyObject? {
        for object in self {
            let objectClass: AnyClass = type(of: object) as! AnyClass
            
            if objectClass == cls {
                return object as AnyObject?
            }
        }
        
        return nil
    }
}
