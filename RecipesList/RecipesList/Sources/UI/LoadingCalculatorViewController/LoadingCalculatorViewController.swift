//
//  LoadingCalculatorViewController.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit
import RxSwift

fileprivate let headerCellHeight: CGFloat = 140
class LoadingCalculatorViewController: TableViewController {
    let desposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    var recipe: Recipe? {
        didSet {
            _ = recipe.flatMap({ calculatedRecipe.fillWithRecipe($0) })
        }
    }
    
    var calculatedRecipe = CalculatedRecipe()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = headerCellHeight
        
        tableView.registerCells(withClasses: [CalculateValueCell.self, RecipeComponentCell.self])
    }
    
    func onCalculate(_ textField: UITextField) {
        guard let weight = Float(textField.text!) else { return }
        if recipe?.weight != weight {
            _ = calculatedRecipe.applyToWeight(weight).subscribe { [weak self] (event) in
                self?.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            }.addDisposableTo(desposeBag)
        }
    }
}

extension LoadingCalculatorViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe != nil && section != 0 ? recipe!.components.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: RecipeDetailCell
        let section = indexPath.section
        var object: AnyObject? = recipe
        if section == 0 {
            cell = tableView.dequeueCellWithClass(CalculateValueCell.self, indexPath: indexPath)
            if let cell = cell as? CalculateValueCell {
                cell.calculateFunction = onCalculate
            }
        } else {
            cell = tableView.dequeueCellWithClass(RecipeComponentCell.self, indexPath: indexPath)
            object = calculatedRecipe.components[indexPath.row]
        }
        
        if (object != nil) {
            cell.object = object
        }
        
        return cell
    }
}
