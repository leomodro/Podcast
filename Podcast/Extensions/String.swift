//
//  String.swift
//  Podcast
//
//  Created by Leonardo Modro on 13/03/2018.
//  Copyright © 2018 Leonardo Modro. All rights reserved.
//

import Foundation

extension String {
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
