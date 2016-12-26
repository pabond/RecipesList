//
//  CDComponent+CoreDataProperties.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/24/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import Foundation
import CoreData


extension CDComponent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDComponent> {
        return NSFetchRequest<CDComponent>(entityName: "CDComponent");
    }

    @NSManaged public var componentDosage: Float
    @NSManaged public var componentName: String?
    @NSManaged public var recipe: CDRecipe?

}
