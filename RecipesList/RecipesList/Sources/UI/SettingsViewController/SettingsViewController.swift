//
//  SettingsViewController.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/13/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

class SettingsViewController: TrancitionViewController {
    var editFunction: ((_ sender: Any) -> ())?
    var deleteFunction: ((_ sender: Any) -> ())?
    var calculateFunction: ((_ sender: Any) -> ())?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupTransition()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCancel(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupTransition() {
        slideInTransitioningDelegate.direction = .bottom
        slideInTransitioningDelegate.size = .twoThirds
        self.transitioningDelegate = slideInTransitioningDelegate
        self.modalPresentationStyle = .custom
    }
    
    @IBAction func onEdit(_ sender: Any) {
        dismiss(animated: true, completion: { [weak self] in
            self?.editFunction.map { $0(sender) }
        })
    }
    
    @IBAction func onCalculate(_ sender: Any) {
        dismiss(animated: true, completion: { [weak self] in
            self?.calculateFunction.map { $0(sender) }
        })
    }

    @IBAction func onDelete(_ sender: Any) {
        dismiss(animated: true, completion: { [weak self] in
            self?.deleteFunction.map { $0(sender) }
        })
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
