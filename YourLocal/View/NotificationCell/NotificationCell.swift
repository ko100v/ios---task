//
//  NotificationCell.swift
//  YourLocal
//
//  Created by Dimitar Kostov on 1/19/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

protocol NotificationCellTypeDelegate {
    func updateCellHeight(height: CGFloat, forRowAtIndexPath: NSIndexPath)
}

/**
 Enumeration for determ cell design type
 
 - Post:
 - Comment:
 */
enum NotificationCellType {
    case Post
    case Comment
    case Other
    
    init() {
        // Set .Post as default
        self = .Post
    }
}

class NotificationCell: UITableViewCell {

    // MARK: - 
    // MARK: Public Interface
    
    internal var time: String! {
        didSet {
            timeAgoLabel.text = time
        }
    }
    
    internal var comment: String! {
        didSet {
            commentLabel?.text = comment
        }
    }
    
    internal var notificationType: String! {
        didSet {
            self.typeLabel.text = notificationType
        }
    }
    
    internal var delegate: NotificationCellTypeDelegate?
    
    internal var estimatedHeight: CGFloat = 0
    
    // MARK: -
    // MARK: Private Interface
    
    private var type = NotificationCellType()
    
    private var typeImageView: UIImageView! {
        didSet {
            typeImageView.image = UIImage(named: (self.type == .Post ? Images.Post : Images.Comment))
            addSubview(typeImageView)
        }
    }
    
    private var typeLabel: UILabel! {
        didSet {
            typeLabel.textColor = AppColor.lightBlueColor()
            typeLabel.font = UIFont(name: Fonts.LatoLight, size: 15)
            typeLabel.adjustsFontSizeToFitWidth = true
            addSubview(typeLabel)
        }
    }
    
    private var clockImageView: UIImageView! {
        didSet {
            clockImageView.image = UIImage(named: "Clock")
            addSubview(clockImageView)
        }
    }
    
    private var timeAgoLabel: UILabel! {
        didSet {
            timeAgoLabel.textColor = AppColor.grayColor()
            timeAgoLabel.font = BaseRegularFont()
            addSubview(timeAgoLabel)
        }
    }
    
    private var commentLabel: UILabel? {
        didSet {
            commentLabel?.numberOfLines = 0
            commentLabel?.textAlignment = .Left
            commentLabel?.lineBreakMode = .ByCharWrapping
            commentLabel?.font = BaseRegularFont()
            addSubview(commentLabel!)
        }
    }
    
    private var separator: UIView! {
        didSet {
            separator.backgroundColor = .lightGrayColor()
            addSubview(separator)
        }
    }
    
    /**
        Images
     */
    private struct Images {
        static let Post: String = "Heart"
        static let Comment: String = "Comment"
        static let Default: String = "Avatar Default"
        static let Clock: String = "Clock"
    }
    
    // MARK: -
    // MARK: Constructor

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, delegate: NotificationCellTypeDelegate, index: Int) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.delegate = delegate
        self.tag = index
        setupUI()
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, notificationCellType: NotificationCellType) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.type = notificationCellType
        setupUI()
    }
    
    // MARK: -
    // MARK: Override Base
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /**
        Layout && Geometry
        */
        
        imageView?.frame = CGRect(
            x: Basic.Offset.YourLocalBasicOffset,
            y: Basic.Offset.YourLocalBasicOffset,
            width: Basic.Size.ProfileImageViewSize.height,
            height: Basic.Size.ProfileImageViewSize.height
        )
        
        timeAgoLabel.frame = CGRect(
            x: frame.size.width - (getSizeForString(timeAgoLabel.text!).width + Basic.Offset.YourLocalBasicOffset),
            y: (imageView?.frame.origin.y)!,
            width: getSizeForString(timeAgoLabel.text!).width,
            height: Basic.Size.TimeAgoLabelSize.height
        )
        
        clockImageView.frame = CGRect(
            x: timeAgoLabel.frame.minX - (Basic.Size.ClockImageViewSize.width + Basic.Offset.x),
            y: timeAgoLabel.frame.origin.y,
            width: Basic.Size.ClockImageViewSize.width,
            height: Basic.Size.ClockImageViewSize.height
        )
        
        textLabel?.frame = CGRect(
            x: imageView!.frame.maxX + Basic.Offset.YourLocalBasicOffset,
            y: imageView!.frame.origin.y,
            width: frame.size.width - (imageView!.frame.maxX + 2*Basic.Offset.YourLocalBasicOffset + (frame.size.width - clockImageView.frame.minX)),
            height: Basic.Size.Height.TextLabelHeight
        )

        typeImageView.frame = CGRect(
            x: textLabel!.frame.origin.x,
            y: textLabel!.frame.maxY,
            width: Basic.Size.TypeImageViewSize.width,
            height: Basic.Size.TypeImageViewSize.height
        )
        
        typeLabel.frame = CGRect(
            x: typeImageView.frame.maxX + (Basic.Offset.x / 2),
            y: typeImageView.frame.origin.y,
            width: textLabel!.frame.size.width - (typeImageView.frame.size.width + (Basic.Offset.x / 2)) ,
            height: 20
        )
        
        if self.type == .Comment {
            let stringWidth = LayoutManager.getWidthOfString(comment, withFont: BaseRegularFont())
            let stringHeight = LayoutManager.getHeightOfString(comment, withFont: BaseRegularFont())
            let lineNumbers = LayoutManager.getLinesForLabelForStringWidth(stringWidth, labelWidth: Basic.Size.Width.CommentLabelWidth)
            let commentLabelHeight = ceil(lineNumbers) * ceil(stringHeight)
            commentLabel?.frame = CGRect(x: typeImageView.frame.origin.x, y: typeImageView.frame.maxY, width: Basic.Size.Width.CommentLabelWidth, height: commentLabelHeight)
            separator.frame = CGRectMake(0, commentLabel!.frame.maxY + (Basic.Offset.YourLocalBasicOffset/2), frame.size.width, 1)
            return
        }
        
        separator.frame = CGRectMake(0, typeLabel!.frame.maxY + (Basic.Offset.YourLocalBasicOffset/2), frame.size.width, 1)

    }
    
    // MARK: -
    // MARK: Public Implementation
    
    // MARK: -
    // MARK: Private Implementation
    

    private func getSizeForString(string: String) -> CGSize {
        return  NSString(string: string).sizeWithAttributes([NSFontAttributeName : timeAgoLabel.font])
    }
    
    /**
    Initialization && Configuration
    */
    private func setupUI() {
        
        /**
        * Configuration
        */
        
        selectionStyle = .None
        
        imageView?.layer.cornerRadius = 25
        imageView?.backgroundColor = .yellowColor()
        imageView?.clipsToBounds = true
        imageView?.image = UIImage(named: Images.Default)
        
        textLabel!.textColor = AppColor.darkBlueColor()
        textLabel!.backgroundColor = .whiteColor()
        textLabel?.font = BaseBoldFont()
        
        typeImageView = UIImageView()
        timeAgoLabel = UILabel()
        clockImageView = UIImageView()
        typeLabel = UILabel()
        
        if type == .Comment {
            commentLabel = UILabel()
        }
        
        separator = UIView()
        
    }
    
    // MARK: -
    // MARK: Actions && Selectors

}
