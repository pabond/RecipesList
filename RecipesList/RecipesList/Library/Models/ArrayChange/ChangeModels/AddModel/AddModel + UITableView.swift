//
//  AddModel + UITableView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

extension AddModel {
    override func apply(to tableView: UITableView, with rowAnimation: UITableViewRowAnimation) {
        tableView.update({ [weak self] in
            if let weakSelf = self {
                tableView.insertRows(at: [weakSelf.tIndexPath], with: rowAnimation)
            }
        })
    }
}
