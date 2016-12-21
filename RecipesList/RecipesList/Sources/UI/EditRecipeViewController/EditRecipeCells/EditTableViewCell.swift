//
//  EditTableViewCell.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/8/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class EditTableViewCell: TableViewCell {
    var textFieldDidEdit: ((_ cell: EditTableViewCell, _ textField: UITextField) -> ())?
    var startEditTextField: ((_ cell: EditTableViewCell, _ textField: UITextField) -> ())?
    var addFunction: (() -> ())? =  {}
    var textFields: [UITextField]? {
        didSet {
            configureTextField()
        }
    }
    
    func configureTextField() {
        var counter = 0
        textFields?.forEach({
            $0.tag = counter
            counter += 1
            $0.delegate = self
        })
    }
}

extension EditTableViewCell : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        startEditTextField.map { $0(self, textField) }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldDidEdit.map { $0(self, textField) }
    }
}
