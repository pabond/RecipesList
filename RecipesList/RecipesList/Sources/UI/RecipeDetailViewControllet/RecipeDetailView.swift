//
//  RecipeDetailView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

fileprivate let headerCellHeight: CGFloat = 170.0

class RecipeDetailView: UIView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    override func awakeFromNib() {
        settingsButtonStyle()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = headerCellHeight
    }
    
    func settingsButtonStyle() {
        self.settingsButton.title = NSString(string: "\u{2699}") as String
        if let font = UIFont(name: "Helvetica", size: 18.0) {
            self.settingsButton.setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState.normal)
        }
    }
}
