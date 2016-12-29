//
//  RecipesViewController.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit
import RxSwift

class RecipesViewController: ViewController {
    let disposeBag = DisposeBag()
    var recipesView: RecipesView?
    var recipes: [AnyObject]? {
        get {
            return user?.recipes?.allObjects as [AnyObject]?
        }
    }

    var user: CDUser?
    
    fileprivate let inset: CGFloat = 10.0
    fileprivate var itemsPerRow: CGFloat = 2
    fileprivate var rowHeight: CGFloat = 130
    
    //MARK: -
    //MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isViewLoaded {
            recipesView?.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesView = viewGetter()
        recipesView?.collectionView.registerCell(withClass: RecipeCollectionViewCell.self)
        user?.recipesList?.observable.subscribe({ (change) in
            _ = change.map({ $0.applyToCollectionView((self.recipesView?.collectionView)!) })
        }).addDisposableTo(disposeBag)
    }
    
    //MARK: -
    //MARK: Interface Handling
    
    @IBAction func onAdd(_ sender: Any) {
        performSegue(toViewControllerWithClass: EditRecipeViewController.self, sender: CDRecipe.mr_createEntity())
    }
    
    @IBAction func onLogout(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: -
    //MARK: Public implementations
    
    func addNewRecipe(_ recipe : CDRecipe?) {
        recipe?.user = user
        user?.recipesList?.addModel(recipe)
//        recipesView?.collectionView.reloadData()
    }
    
    func deleteRecipe(_ recipe: CDRecipe?) {
        if let recipe = recipe {
            user?.recipesList?.removeModel(recipe)
//            recipesView?.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        let recipe = sender as? CDRecipe
        if identifier == String(describing: EditRecipeViewController.self) {
            guard let editVC = segue.destination as? EditRecipeViewController else { return }
            editVC.doneFunction = addNewRecipe
            editVC.recipe = recipe
        } else if identifier == String(describing: RecipeDetailViewController.self) {
            guard let detailVC = segue.destination as? RecipeDetailViewController else { return }
            detailVC.recipe = recipe
            detailVC.deleteFunction = deleteRecipe
        }
    }
}

//MARK: -
//MARK: UICollectionViewDataSource
    
extension RecipesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cellWithClass(RecipeCollectionViewCell.self, for: indexPath) as! RecipeCollectionViewCell
        cell.object = recipes?[indexPath.row]
        
        return cell
    }
}

//MARK: -
//MARK: UICollectionViewDelegate

extension RecipesViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        performSegue(toViewControllerWithClass: RecipeDetailViewController.self, sender: recipes?[indexPath.row])
    }
}

//MARK: -
//MARK: UICollectionViewDelegateFlowLayout
extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    // This method is responsible for telling the layout the size of a given cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let frameWidth = view.frame.width
        let paddingSpace = inset * (itemsPerRow + 1)
        var widthPerItem = frameWidth - paddingSpace
        if isRegularWidthOrCompactWidthAndCompactHeight {
            widthPerItem /= itemsPerRow
        }
            
        return CGSize(width: widthPerItem, height: rowHeight)
    }
    
    // This method returns the spacing between the cells, headers, and footers
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        recipesView?.collectionView.collectionViewLayout.invalidateLayout()
    }
}
