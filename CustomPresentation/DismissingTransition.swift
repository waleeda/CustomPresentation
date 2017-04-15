//
//  DismissingTransition.swift
//  testing
//
//  Created by waleed azhar on 2017-04-15.
//  Copyright © 2017 waleed azhar. All rights reserved.
//

import UIKit

class DismissingTransition:NSObject, UIViewControllerAnimatedTransitioning{
    
    var anim: UIViewPropertyAnimator?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let s = self.interruptibleAnimator(using: transitionContext)
        s.startAnimation()
    }
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        
        guard self.anim == nil else {
            return self.anim!
        }
        
        
        let vc1 = transitionContext.viewController(forKey: .from)!
        let vc2 = transitionContext.viewController(forKey: .to)!
        let v1 = transitionContext.view(forKey: .from)!
        
        let anim =  UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.9) {
            v1.alpha = 0
            v1.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }
        anim.addCompletion { (_) in
            v1.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        self.anim = anim
        
        return anim
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        if transitionCompleted {
            self.anim = nil
        }
    }
}
