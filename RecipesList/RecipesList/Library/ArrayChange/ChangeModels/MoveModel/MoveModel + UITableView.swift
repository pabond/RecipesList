//
//  MoveModel + UITableView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

extension MoveModel {
    override func apply(to tableView: UITableView, with rowAnimation: UITableViewRowAnimation) {
        tableView.update({ [weak self] in
            if let indexPath = self?.indexPath, let toIndexPath = self?.toIndexPath {
                tableView.moveRow(at: indexPath, to: toIndexPath)
            }
        })
    }
}
