//
//  DBArrayModel.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

let kBatchSize: Int = 10
let kCacheName = "Master"

class DBArrayModel: ArrayModel {
    var predicate: NSPredicate? {
        get { return nil }
    }
    
    var sortDesriptor: NSSortDescriptor {
        get { return NSSortDescriptor(key: "", ascending: false) }
    }
    
    override var models: [AnyObject] {
        get {
            return fetchedResultsController?.fetchedObjects ?? super.models
        }
        set {
            self.models = newValue
        }
    }
    
    var batchSize: Int {
        get { return kBatchSize }
    }
    
    var keyPath: String?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    var object: NSManagedObject?
    
    var entityName: String {
        get { return "" }
    }

    init(with object: NSManagedObject?, keyPath path: String) {
        super.init()
        
        self.keyPath = path
        self.object = object
        fetchedResultsController = controller()
    }
    
    func controller() -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.fetchBatchSize = batchSize
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDesriptor]
        let context = NSManagedObjectContext.mr_default()
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: kCacheName)
        controller.delegate = self
        
        return controller
    }
   
    func performLoading() {
        do {
            try self.fetchedResultsController?.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
    }
    
    override func addModel(_ model: AnyObject?) {
        if model != nil {
            object?.addCustomValue(model, forKey: keyPath)
        }
    }
    
    override func removeModel(_ model: AnyObject?) {
        if model != nil {
            object?.removeCustomValue(model, forKey: keyPath)
        }
    }
        
    override func model(at index: Int?) -> AnyObject? {
        return index != nil ? self.models[index!] : nil
    }
    
    override func indexOfModel(_ model: AnyObject?) -> Int? {
        if model == nil {
            return nil
        }
        
        return (models.index(where: { $0 === model }))
    }

    override func removeModelAtIndex(_ index: Int?) {
        removeModel(model(at: index))
    }

    override func moveModel(from index: Int, to destIndex: Int) {
        return
    }
    
    override func insert(_ model: AnyObject?, at index: Int?) {
        return
    }
}

// Mark -
// Mark NSFetchedResultsControllerDelegate

extension DBArrayModel : NSFetchedResultsControllerDelegate {
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChangeObject anObject: AnyObject,
                    atIndexPath indexPath: NSIndexPath?,
                    forChangeType type: NSFetchedResultsChangeType,
                    newIndexPath: NSIndexPath?)
    {
        switch type {
        case .insert: break
            
        case .delete: break
            
        case .update: break
            
        case .move: break
            
        }
    }
}
