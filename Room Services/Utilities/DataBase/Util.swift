//
//  Util.swift
//  LynkedWorld
//
//  Created by Macbook on 01/11/17.
//  Copyright © 2017 Arusys. All rights reserved.
//

import UIKit

class Util: NSObject {

    class func getFilePath(fileName: String) -> String {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let destinationPath:NSString = documentsPath.appendingFormat(fileName) as NSString
        return destinationPath as String
    }
    
}
