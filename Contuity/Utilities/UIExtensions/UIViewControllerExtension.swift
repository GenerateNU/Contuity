//
//  UIViewControllerExtension.swift
//  Contuity
//
//  Created by Anand Kumar on 11/14/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Present a UIViewController function in the main thread.
    ///
    /// - Parameters:
    ///   - viewcontroller: the UIViewController
    ///   - isAnimated: true if to show animations, false otherwise
    ///   - completion: A nullary function completion
    func presentInMainThread(_ viewcontroller: UIViewController,
                             isAnimated: Bool,
                             function: (() -> Void)? = nil) {
        DispatchQueue.dispatchToMain {
            self.present(viewcontroller, animated: isAnimated, completion: function)
        }
    }
}
