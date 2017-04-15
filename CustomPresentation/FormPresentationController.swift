//
//  FormPresentationController.swift
//  testing
//
//  Created by waleed azhar on 2017-04-15.
//  Copyright © 2017 waleed azhar. All rights reserved.
//

import UIKit

class FormPresentationController: UIPresentationController {
    
    override var presentedView: UIView? {
        let v = super.presentedView!
        v.layer.cornerRadius = 6
        v.layer.masksToBounds = true
        return v
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let frame = super.frameOfPresentedViewInContainerView.insetBy(dx: 0, dy: 40)
        return frame
    }
    
    override func presentationTransitionWillBegin() {
        let con = containerView!
        let shadow = UIView(frame: con.bounds)
        shadow.backgroundColor = UIColor(white: 0, alpha: 0.4)
        con.insertSubview(shadow, at: 0)
        shadow.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        shadow.alpha = 0
        let tc = self.presentedViewController.transitionCoordinator!
        
        tc.animate(alongsideTransition: { (nil) in
            shadow.alpha = 1
        }, completion: nil )
        
    }
    
    override func dismissalTransitionWillBegin() {
        let con = containerView!
        let shadow = con.subviews[0]
        let tc = self.presentedViewController.transitionCoordinator!
        tc.animate(alongsideTransition: { (_) in
            shadow.alpha = 0
        }, completion: nil)
        
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        let vc = presentingViewController
        let v = vc.view
        v?.tintAdjustmentMode = .dimmed
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        let vc = presentingViewController
        let v = vc.view
        v?.tintAdjustmentMode = .automatic
    }
}
