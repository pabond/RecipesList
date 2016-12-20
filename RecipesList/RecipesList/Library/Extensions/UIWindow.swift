//
//  UIWindow.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

extension UIWindow {
    class func window() -> UIWindow {
        return self.init(frame:UIScreen.main.bounds)
    }
}
