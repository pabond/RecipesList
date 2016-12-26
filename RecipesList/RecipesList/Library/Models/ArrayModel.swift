//
//  ArrayModel.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/1/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

let notFound = Int(INT_MAX)

enum ModelChangeState {
    case BPVModelDidChange, BPVArrayModelCount
}

@objc protocol ArrayModelObserver {
    @objc optional func model(_ model: AnyObject, didChangeWithModel changeModel: AnyObject)
}

extension ArrayModel : Sequence {
    public typealias Iterator = NSFastEnumerationIterator
    
    public func makeIterator() -> NSFastEnumerationIterator {
        return NSFastEnumerationIterator(self as! NSFastEnumeration)
    }
}

class ArrayModel : Model {
    var models = Array<AnyObject>()
    var count: Int {
        get {
            return models.count
        }
    }
    
    subscript(index: Int) -> AnyObject {
        get {
            return models[index]
        }
    }
    
    func addModel(_ model: AnyObject?) {
        if model == nil {
            return
        }
        
        models.append(model!)
    }
    
    func addModels(_ objects: Array<AnyObject>) {
        for object in objects {
            addModel(object)
        }
    }
    
    func model(at index: Int?) -> AnyObject? {
        if index == nil && index! < count {
            return nil
        }
        
        return models[index!]
    }
   
    func containsModel(_ model: AnyObject?) -> Bool {
        if model == nil && models.isEmpty {
            return false
        }
        
        return (models.contains(where: { $0 === model }))
    }
    
    func indexOfModel(_ model: AnyObject?) -> Int? {
        if model == nil && !containsModel(model) {
            return nil
        }
        
        return (models.index(where: { $0 === model}))!
    }
    
    func removeModel(_ model: AnyObject?) {
        if model == nil && !containsModel(model) {
            return
        }
        
        removeModelAtIndex(indexOfModel(model))
    }
    
    func removeModelAtIndex(_ index: Int?) {
        if index == nil && count > index! {
            return
        }
        
        models.remove(at: index!)
    }
    
    func insert(_ model: AnyObject?, at index: Int?) {
        if model != nil && index != nil {
            models.insert(model!, at: index!)
        }
    }
    
    func moveModel(from index: Int, to destIndex: Int) {
        models.move(from: index, to: destIndex)
    }
}
