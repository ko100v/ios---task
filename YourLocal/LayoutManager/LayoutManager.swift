//
//  LayoutManager.swift
//  YourLocal
//
//  Created by Dimitar Kostov on 1/20/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

/// **** LayoutManager ****
class LayoutManager {
    
    class func getWidthOfString(string: String, withFont font: UIFont) -> CGFloat {
        return NSString(string: string).sizeWithAttributes([NSFontAttributeName : font]).width
    }
    
    class func getHeightOfString(string: String, withFont font: UIFont) -> CGFloat {
        return NSString(string: string).sizeWithAttributes([NSFontAttributeName : font]).height
    }
    
    class func getLinesForLabelForStringWidth(stringWidth: CGFloat, labelWidth: CGFloat) -> CGFloat {
        return stringWidth / labelWidth
    }
}