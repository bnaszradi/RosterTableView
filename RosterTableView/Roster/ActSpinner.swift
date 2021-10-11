//
//  ActSpinner.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 8/13/21.
//

import UIKit

fileprivate var aView : UIView?

extension UIViewController {
    
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView!.center
        ai.color = .white
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
        
    }  // showSpinner func
    
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
        
    }  //removeSpinner func
    
    
    
}  // extenstion UIViewController
