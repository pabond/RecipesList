//
//  RoundedView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/8/16.
//  Copyright © 2016 goit.taras.spasibov. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundedView(cornerRadius: 12)
    }
}

extension UIView {
    func roundedView(cornerRadius: CGFloat) -> Void {
        self.layer.cornerRadius = cornerRadius
    }
}
