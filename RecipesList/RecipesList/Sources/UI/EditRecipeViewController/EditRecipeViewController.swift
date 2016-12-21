//
//  EditRecipeViewController.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/2/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

fileprivate let headerCellHeight: CGFloat = 225.0

class EditRecipeViewController: UITableViewController {
    var doneFunction: ((_ recipe: Recipe?) -> ())?
    var recipe: Recipe?
    var cells = [UITableViewCell]()
    
    fileprivate var startEditTextField: UITextField?
    fileprivate var editTextFieldCell: EditTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCells(withClasses: [RecipeEditHeaderCell.self, RecipeComponentEditCell.self])
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = headerCellHeight
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath)
    {
        let row = indexPath.row
        if editingStyle == .delete {
            recipe?.removeComponentAtIndex(row - 1)
            tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
    
    @IBAction func onDone(_ sender: Any) {
        cellDidEdit(editTextFieldCell, didEdit: startEditTextField)
        prepareComponentsForSave()
        doneFunction.map { $0(recipe) }
        _ = navigationController?.popViewController(animated: true)
    }
    
    func prepareComponentsForSave() {
        
    }
    
    func onAddComponent() {
        recipe?.addComponent(RecipeComponent())
        tableView.insertRows(at: [IndexPath.init(row: (recipe?.components.count)!, section: 0)], with: .automatic)
    }
    
    func onTextFieldStartEdit(_ cell: EditTableViewCell, didEdit textField: UITextField) {
        startEditTextField = textField
        editTextFieldCell = cell
    }
    
    func cellDidEdit(_ cell: EditTableViewCell?, didEdit textField: UITextField?) -> () {
        let text = textField?.text ?? ""
        guard let cell = cell else { return }
        guard let textField = textField else { return }
        guard let row = tableView.indexPath(for: cell)?.row else { return }
        let tag = textField.tag
        
        if row == 0 {
            switch tag {
            case 0: recipe?.name = text
            case 1: recipe?.applications = text
            case 2: recipe?.companies = text
            default:
                break
            }
        } else {
            guard let component = recipe?.componentAtIndex(row - 1)
                else { return }
            switch tag {
            case 0: component.componentName = text
            case 1:
                guard let floatStr = Float(text) else { return }
                component.componentDosage = floatStr
            default:
                break
            }
        }
    }
}

extension EditRecipeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipe?.components.count)! + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: EditTableViewCell
        let row = indexPath.row
        var object: AnyObject? = recipe
        if row == 0 {
            cell = tableView.dequeueCellWithClass(RecipeEditHeaderCell.self, indexPath: indexPath)
            cell.addFunction = onAddComponent
        } else {
            cell = tableView.dequeueCellWithClass(RecipeComponentEditCell.self, indexPath: indexPath)
            object = recipe?.components[row - 1]
        }
        
        if object != nil {
            cell.object = object!
        }
        
        cell.textFieldDidEdit = cellDidEdit
        cell.startEditTextField = onTextFieldStartEdit
        
        return cell
    }
}
