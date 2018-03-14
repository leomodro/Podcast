//
//  CMTime.swift
//  Podcast
//
//  Created by Leonardo Modro on 14/03/2018.
//  Copyright © 2018 Leonardo Modro. All rights reserved.
//

import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormatString
    }
    
}
