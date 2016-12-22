//
//  UIViewController.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    func viewGetter<V>() -> V? {
        return self.viewIfLoaded.flatMap({$0 as? V})
    }
    
    var isRegularWidthAndRegularHeight: Bool {
        let sizeClass = self.traitCollection
        return sizeClass.verticalSizeClass == .regular && sizeClass.horizontalSizeClass ==  .regular
    }
    
    var isRegularWidth: Bool {
        return self.traitCollection.horizontalSizeClass ==  .regular
    }
    
    var isRegularWidthOrCompactWidthAndCompactHeight: Bool {
        return isRegularWidth || isCompactWidthAndCompactHeight
    }
    
    var isCompactWidthAndCompactHeight: Bool {
        let sizeClass = self.traitCollection
        
        return sizeClass.verticalSizeClass == .compact && sizeClass.horizontalSizeClass ==  .compact
    }
    
    class func viewController() -> UIViewController {
        return self.init(nibName:nibName(), bundle:nil)
    }
    
    class func nibName() -> String {
        return  String(describing: self)
    }

    func performSegue(toViewControllerWithClass cls: AnyClass, sender: Any?) {
        performSegue(withIdentifier: String(describing: cls.self), sender: sender)
    }
}
