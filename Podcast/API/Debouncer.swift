//
//  Debouncer.swift
//  Podcast
//
//  Created by Leonardo Modro on 14/03/2018.
//  Copyright © 2018 Leonardo Modro. All rights reserved.
//

import UIKit

class Debouncer {
    var callback: (() -> Void)?
    private let interval: TimeInterval
    private var timer: Timer?
    
    init(interval: TimeInterval) {
        self.interval = interval
    }
    
    func call() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: false)
    }
    
    @objc private func handleTimer(_ timer: Timer) {
        if callback == nil {
            NSLog("Debouncer timer fired, but callback was nil")
        } else {
            NSLog("Debouncer timer fired")
        }
        callback?()
        callback = nil
    }
}
