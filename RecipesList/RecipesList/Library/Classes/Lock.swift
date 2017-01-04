//
//  Lock.swift
//  RecipesList
//
//  Created by Bondar Pavel on 1/4/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import Foundation

class Lock: NSObject {
    public class func sync(_ lock: AnyObject, withBlock block: () -> ()) {
        objc_sync_enter(lock)
        block()
        objc_sync_exit(lock)
    }
}
