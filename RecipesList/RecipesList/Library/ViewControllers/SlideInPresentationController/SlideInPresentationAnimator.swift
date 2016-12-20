//
//  SlideInPresentationAnimator.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/13/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

final class SlideInPresentationAnimator: NSObject {
    
    let direction: SlideInPresentationManagerDirection
    let isPresentation: Bool
    
    init(direction: SlideInPresentationManagerDirection, isPresentation: Bool) {
        self.direction = direction
        self.isPresentation = isPresentation
        super.init()
    }
}

extension SlideInPresentationAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to
            : UITransitionContextViewControllerKey.from

        let controller = transitionContext.viewController(forKey: key)!
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }
    
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        
        switch direction {
        case .left:
            dismissedFrame.origin.x = -presentedFrame.width
        case .right:
            dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
        case .top:
            dismissedFrame.origin.y = -presentedFrame.height
        case .bottom:
            dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
        }
        
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        
        UIView.animate(withDuration: animationDuration, animations: {
            controller.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
