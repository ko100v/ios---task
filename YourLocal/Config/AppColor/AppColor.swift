/**
 *  Custom Application Colors
 */

import UIKit

class AppColor: NSObject {
    
    /**
     **** Application Main Light Blue Color ****
     
     - returns: UIColor
     */
    class func lightBlueColor() -> UIColor {
        return UIColor(red: 0.000, green: 0.565, blue: 0.706, alpha: 1.00)
    }
    
    /**
     **** Application Main Blue Color ****
     
     - returns: UIColor
     */
    class func blueColor() -> UIColor {
        return UIColor(red: 0.098, green: 0.518, blue: 0.808, alpha: 1.00)
    }
    
    /**
     **** Application Main Dark Blue Color ****
     
     - returns: UIColor
     */
    class func darkBlueColor() -> UIColor {
        return UIColor(red: 0.035, green: 0.506, blue: 0.816, alpha: 1.00)
    }
    
    /**
     **** Application Main Green Color ****
     
     - returns: UIColor
     */
    class func greenColor() -> UIColor {
        return UIColor(red: 0.231, green: 0.812, blue: 0.518, alpha: 1.00)
    }
    
    /**
     **** Application Main Gray Color ****
     
     - returns: UIColor
     */
    class  func grayColor() -> UIColor {
        return UIColor(red: 0.533, green: 0.541, blue: 0.580, alpha: 1.00)
    }

}