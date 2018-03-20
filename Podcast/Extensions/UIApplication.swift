//
//  UIApplication.swift
//  Podcast
//
//  Created by Leonardo Modro on 20/03/2018.
//  Copyright © 2018 Leonardo Modro. All rights reserved.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainTabBarController? {
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}
