//
//  ArrayChange + UITableView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

extension ArrayChange {
        
    func apply(to tableView: UITableView) {
        self.apply(to: tableView, with: .automatic)
    }
    
    func apply(to tableView: UITableView, with rowAnimation: UITableViewRowAnimation) {
        return
    }
}
