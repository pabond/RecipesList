//
//  RemoveModel + UICollectionView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

extension RemoveModel {
    override func applyToCollectionView(_ collectionView: UICollectionView) {
        if let indexPath = self.indexPath {
            collectionView.deleteItems(at: [indexPath])
        }
    }
}
