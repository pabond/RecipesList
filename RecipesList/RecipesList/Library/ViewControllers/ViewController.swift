//
//  ViewController.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var baseView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseView = viewGetter()
    }
    
    func popCurrentViewController() {
        _ = navigationController?.popViewController(animated: true)
    }
}

