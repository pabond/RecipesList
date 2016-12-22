//
//  DBArrayModel.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

let kBatchSize: Int = 20
let kCacheName = "Master"
let kUserID = "userID"


class DBArrayModel: ArrayModel, NSFetchedResultsControllerDelegate {
    var predicate: NSPredicate? {
        get {
            if keyPath != nil && self.object != nil {
                return NSPredicate(format: "%K contains %@", argumentArray: [self.keyPath!, self.object!])
            }
            
            return nil
        }
    }
    
    var sortDesriptor: NSSortDescriptor {
        get {
            return NSSortDescriptor(key: kUserID, ascending: false)
        }
    }
    
    override var models: [AnyObject] {
        get {
            return fetchedResultsController.fetchedObjects ?? super.models
        }
        set {
            self.models = newValue
        }
    }
    
    var batchSize: Int {
        get {
            return kBatchSize
        }
    }
    
    var keyPath: String?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> {
        didSet {
            fetchedResultsController.delegate = self
        }
    }
    var object: NSManagedObject?

    init(with object: NSManagedObject, keyPath path: String) {
        super.init()
        
        self.object = object
        self.keyPath = path
        self.fetchedResultsController = controller()
    }
    
    func controller() -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type(of: object)))
        fetchRequest.fetchBatchSize = batchSize
        fetchRequest.sortDescriptors = [sortDesriptor]
        fetchRequest.predicate = predicate
        let context = NSManagedObjectContext.mr_default()
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: kCacheName)
        
        return controller
    }
   
    func performLoading() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
    }
    
    override func addModel(_ model: AnyObject?) {
        object?.addCustomValue(model, forKey: keyPath)
    }
    
    override func removeModel(_ model: AnyObject?) {
        if containsModel(model) {
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
    
    override func count() -> Int {
        return models.count
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
    
    override func containsModel(_ model: AnyObject?) -> Bool {
        
    }
    
    /*
    - (BOOL)containsModel:(NSManagedObject *)model {
    @synchronized (self) {
    NSArray *array = [self.fetchedResultsController.fetchedObjects filteredUsingBlock:^BOOL(NSManagedObject *object) {
    return [object.objectID isEqual:model.objectID];
    }];
    
    return (BOOL)array.count;
    }
    }
 */


// Mark -
// Mark NSFetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?)
    {
        
    }
}
