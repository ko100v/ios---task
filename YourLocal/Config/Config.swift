/*
    Configuration file
*/

import UIKit

 /// Determ application modes
public var inDebug: Bool = true

public struct CellIdentifiers {
    static let DefaultCellId: String = "CellId"
    static let NotificationCellId: String = "NotificationCellId"
}

/**
 * Custom Fonts
*/
public struct Fonts {
    static let LatoRegular: String = "Lato-Regular"
    static let LatoLight: String = "Lato-Light"
    static let LatoBold: String = "Lato-Bold"
}

/**
 * return : Lato bold font with 17.0 size
*/
public func BaseBoldFont() -> UIFont {
    return UIFont(name: Fonts.LatoBold, size: 17.0)!
}

/**
 * return : Lato regular font with 17.0 size
 */
public func BaseRegularFont() -> UIFont {
    return UIFont(name: Fonts.LatoRegular, size: 17.0)!
}

/**
 * return : Lato light font with 17.0 size
 */
public func BaseLightFont() -> UIFont {
    return UIFont(name: Fonts.LatoLight, size: 17.0)!
}

