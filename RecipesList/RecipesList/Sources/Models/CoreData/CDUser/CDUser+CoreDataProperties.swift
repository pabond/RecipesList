//
//  CDUser+CoreDataProperties.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/26/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser");
    }

    @NSManaged public var userID: String?
    @NSManaged public var userName: String?
    @NSManaged public var recipes: NSSet?
}

// MARK: Generated accessors for recipes
extension CDUser {

    @objc(addRecipesObject:)
    @NSManaged public func addToRecipes(_ value: CDRecipe)

    @objc(removeRecipesObject:)
    @NSManaged public func removeFromRecipes(_ value: CDRecipe)

    @objc(addRecipes:)
    @NSManaged public func addToRecipes(_ values: NSSet)

    @objc(removeRecipes:)
    @NSManaged public func removeFromRecipes(_ values: NSSet)

}
