//
//  EditRecipeViewController.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/2/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit
import RxSwift

fileprivate let headerCellHeight: CGFloat = 225.0

class EditRecipeViewController: UITableViewController {
    let disposeBag = DisposeBag()
    var doneFunction: ((_ recipe: CDRecipe?) -> ())?
    var recipe: CDRecipe?
    var cells = [UITableViewCell]()
    
    fileprivate var startEditTextField: UITextField?
    fileprivate var editTextFieldCell: EditTableViewCell?

    //MARK: -
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCells(withClasses: [RecipeEditHeaderCell.self, RecipeComponentEditCell.self])
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = headerCellHeight
        recipe?.componentsList?.observable.subscribe({ (change) in
            _ = change.map({ $0.apply(to: self.tableView) })
        }).addDisposableTo(disposeBag)
    }
    
    //MARK: -
    //MARK: Interface Handling
    
    @IBAction func onDone(_ sender: Any) {
        cellDidEdit(editTextFieldCell, didEdit: startEditTextField)
        doneFunction.map { $0(recipe) }
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func onCancel(_ sender: Any) {
        let count = navigationController?.viewControllers.count
        if count != nil && count! > 1 {
            if ((navigationController?.viewControllers[count! - 2] as? RecipesViewController) != nil) {
                recipe?.mr_deleteEntity()
            }
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func onAddComponent() {
        let component = CDComponent.create(recipe)
        recipe?.componentsList?.addModel(component)
    }
    
    func onTextFieldStartEdit(_ cell: EditTableViewCell, didEdit textField: UITextField) {
        startEditTextField = textField
        editTextFieldCell = cell
    }
    
    //MARK: -
    //MARK: Public Implementations
    
    func cellDidEdit(_ cell: EditTableViewCell?, didEdit textField: UITextField?) -> () {
        let text = textField?.text ?? ""
        guard let cell = cell else { return }
        guard let textField = textField else { return }
        guard let row = tableView.indexPath(for: cell)?.row else { return }
        let tag = textField.tag
        
        if row == 0 {
            switch tag {
            case 0: recipe?.recipeName = text
            case 1: recipe?.recipeApplications = text
            case 2: recipe?.recipeCompanies = text
            default:
                break
            }
        } else {
            guard let component: CDComponent? = recipe?.components?.allObjects[(row - 1)] as? CDComponent?
                else { return }
            switch tag {
            case 0: component?.componentName = text
            case 1:
                guard let floatStr = Float(text) else { return }
                component?.componentDosage = floatStr
            default:
                break
            }
        }
    }
}

//MARK: -
//MARK: UITableViewDataSource

extension EditRecipeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipe?.components?.allObjects.count)! + 1
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
            object = recipe?.components?.allObjects[row - 1] as AnyObject?
        }
        
        if object != nil {
            cell.object = object!
        }
        
        cell.textFieldDidEdit = cellDidEdit
        cell.startEditTextField = onTextFieldStartEdit
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath)
    {
        let row = indexPath.row
        if editingStyle == .delete {
            let component = recipe?.components?.allObjects[row - 1] as? CDComponent
            recipe?.removeFromComponents(component!)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
}
