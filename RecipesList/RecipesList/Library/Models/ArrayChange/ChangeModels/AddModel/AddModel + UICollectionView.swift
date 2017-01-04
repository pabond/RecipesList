//
//  AddModel + UICollectionView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

extension AddModel {
    override func applyToCollectionView(_ collectionView: UICollectionView) {
        if let indexPath = self.indexPath {
            collectionView.insertItems(at: [indexPath])
        }
    }
}
