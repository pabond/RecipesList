//
//  ImageView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 1/4/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import RxSwift

class ImageView: UIView {
    var disposeBag = DisposeBag()
    var imageModel = ImageModel()
    
    @IBOutlet var imageView: UIImageView? {
        get { return self.imageView }
        set {
            if imageView != newValue {
                imageView?.removeFromSuperview()
                
                self.imageView = newValue
                if imageView != nil {
                    self.addSubview(imageView!)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSubviews()
    }
    
    func initSubviews() {
        let imageView = UIImageView(frame: self.bounds)
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.imageView = imageView
    }
    
    func imageWithURL(_ url: URL) {
        _ = imageModel.imageWithURL(url).subscribe(onNext: { (image) in
            self.imageView?.image = image
        }).addDisposableTo(disposeBag)
    }
}
