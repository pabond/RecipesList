//
//  MoveModel + UICollectionView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

extension MoveModel {
    override func applyToCollectionView(_ collectionView: UICollectionView) {
        if let indexPath = self.indexPath, let toIndexPath = self.toIndexPath {
            collectionView.moveItem(at: indexPath, to: toIndexPath)
        }
    }
}
