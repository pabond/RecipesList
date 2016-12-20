//
//  CDRecipe+CoreDataProperties.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import Foundation
import CoreData

extension CDRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRecipe> {
        return NSFetchRequest<CDRecipe>(entityName: "CDRecipe");
    }

    @NSManaged public var recipeName: String?
    @NSManaged public var recipeApplications: String?
    @NSManaged public var recipeCompanies: String?
    @NSManaged public var components: NSSet?

}

// MARK: Generated accessors for components
extension CDRecipe {

    @objc(addComponentsObject:)
    @NSManaged public func addToComponents(_ value: CDComponent)

    @objc(removeComponentsObject:)
    @NSManaged public func removeFromComponents(_ value: CDComponent)

    @objc(addComponents:)
    @NSManaged public func addToComponents(_ values: NSSet)

    @objc(removeComponents:)
    @NSManaged public func removeFromComponents(_ values: NSSet)

}
