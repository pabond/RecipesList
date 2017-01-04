//
//  UpdateModel + UITableView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

extension UpdateModel {
    override func apply(to tableView: UITableView, with rowAnimation: UITableViewRowAnimation) {
        tableView.update({ [weak self] in
            if let weakSelf = self {
                tableView.reloadRows(at: [weakSelf.tIndexPath], with: rowAnimation)
            }
        })
    }
}
