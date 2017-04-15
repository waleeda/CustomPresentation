//
//  PresentingTransition.swift
//  testing
//
//  Created by waleed azhar on 2017-04-15.
//  Copyright © 2017 waleed azhar. All rights reserved.
//

import UIKit

class PresentingTransition:NSObject, UIViewControllerAnimatedTransitioning{
    
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
        
        let vc2 = transitionContext.viewController(forKey: .to)
        let con = transitionContext.containerView
        let r2end = transitionContext.finalFrame(for: vc2!)
        let v2 = transitionContext.view(forKey: .to)!
        
        v2.frame = r2end
        v2.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        v2.alpha = 0
        
        con.addSubview(v2)
        
        let anim = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.5)  {
            v2.alpha = 1
            v2.transform = .identity
        }
        
        anim.addCompletion { (_) in
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
