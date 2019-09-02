//
//  GlobalManager.swift
//  ServSearch
//
//  Created by Vishal Gohel on 8/1/17.
//  Copyright © 2017 Vishal Gohel. All rights reserved.
//

import Foundation
import UIKit
class GlobalManager: NSObject {
    
    var pathArrayObject = [String]()
        var index: Int = 0
        var count: Int = 0
    var imageUrl: String = ""

    
    class var sharedInstance: GlobalManager {
        struct Singleton {
            static let instance = GlobalManager()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        
    }
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
}
