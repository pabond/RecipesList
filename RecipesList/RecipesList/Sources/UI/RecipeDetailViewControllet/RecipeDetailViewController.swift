//
//  RecipeDetailViewController.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class RecipeDetailViewController: ViewController {
    var recipeDetailView: RecipeDetailView?
    var deleteFunction: ((_ recipe: CDRecipe?) -> ())?
    var recipe: CDRecipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeDetailView = viewGetter()
        recipeDetailView?.tableView.registerCells(withClasses: [RecipeDetailHeaderCell.self, RecipeComponentCell.self])
    }
    
    @IBAction func onSettings(_ sender: Any) {
        performSegue(toViewControllerWithClass: SettingsViewController.self, sender: nil)
    }
    
    func onEdit(_ sender: Any) {
        performSegue(toViewControllerWithClass: EditRecipeViewController.self, sender: nil)
    }
    
    func onDelete(_ sender: Any) {
        deleteFunction.map { $0(recipe) }
        popCurrentViewController()
    }
    
    func onCalculate(_ sender: Any) {
        performSegue(toViewControllerWithClass: LoadingCalculatorViewController.self, sender: nil)
    }
    
    func doneEdit(_ recipe: CDRecipe?) {
        recipeDetailView?.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        if identifier == String(describing: SettingsViewController.self) {
            guard let settingsVC = segue.destination as? SettingsViewController else { return }
            settingsVC.deleteFunction = onDelete
            settingsVC.editFunction = onEdit
            settingsVC.calculateFunction = onCalculate
        } else if identifier == String(describing: EditRecipeViewController.self) {
            guard let editVC = segue.destination as? EditRecipeViewController else { return }
            editVC.recipe = recipe
            editVC.doneFunction = doneEdit
        } else if identifier == String(describing: LoadingCalculatorViewController.self) {
            guard let calculateVC = segue.destination as? LoadingCalculatorViewController else { return }
            calculateVC.recipe = recipe
        }
    }
}

extension RecipeDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipe?.components?.count ?? 0) + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: RecipeDetailCell
        let row = indexPath.row
        var object: AnyObject? = recipe
        if row == 0 {
            cell = tableView.dequeueCellWithClass(RecipeDetailHeaderCell.self, indexPath: indexPath)
        } else {
            cell = tableView.dequeueCellWithClass(RecipeComponentCell.self, indexPath: indexPath)
            object = recipe?.components?.allObjects[row - 1] as AnyObject?
        }
        
        if (object != nil) {
            cell.object = object
        }
        
        return cell
    }
}
