//
//  DispatchQueueExtension.swift
//  Contuity
//
//  Created by Anand Kumar on 11/14/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

// MARK: - Extension on the Dispatch Queue to allow more granular control of threading
extension DispatchQueue {
    /// Dispatches an action to the main presentation thread
    ///
    /// - Parameter action: A nullary closure
    static func dispatchToMain(with action: @escaping () -> Void) {
        if Thread.isMainThread {
            action()
        }
        else {
            DispatchQueue.main.async {
                action()
            }
        }
    }
}
