/**
 *  Application Dimensions
 */

import UIKit

/**
 *  Basic Dimensions
 */
public struct Basic {
    
    /**
     *  Default Offset Values
     */
    public struct Offset {
        static let x: CGFloat = 8.0
        static let y: CGFloat = Basic.Offset.x
        static let YourLocalBasicOffset: CGFloat = 20.0
    }
    
    /**
     *  Default Sizes
     */
    public struct Size {
        
        /**
         *  Default Heights
         */
        public struct Height {
            static let StatusBarHeight: CGFloat = 20.0
            static let NavigationBarHeight: CGFloat = 44.0
            static let NavigationBarAndStatusBarHeight = Basic.Size.Height.StatusBarHeight + Basic.Size.Height.NavigationBarHeight
            static let TextLabelHeight: CGFloat = 25
            static let NotificationCellDefaultHeight: CGFloat = 76;
        }
        
        /**
         *  Default Widths
         */
        public struct Width {
            static let CommentLabelWidth: CGFloat = UIScreen.mainScreen().bounds.size.width - (Basic.Size.ProfileImageViewSize.width + 4*Basic.Offset.YourLocalBasicOffset)
        }
        
        // Your local specific size's
        static let ProfileImageViewSize: CGSize = CGSize(width: 50.0, height: 50.0)
        static let TypeImageViewSize: CGSize = CGSize(width: 25, height: 25)
        static let ClockImageViewSize: CGSize = CGSize(width: 20, height: 20)
        static let TimeAgoLabelSize: CGSize = CGSizeMake(40, 20)
    }
}
