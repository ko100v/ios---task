//
//  NotificationViewController.swift
//  YourLocal
//
//  Created by Dimitar Kostov on 1/19/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

class NotificationViewController: BaseController, UITableViewDelegate, UITableViewDataSource, NotificationCellTypeDelegate {

    // MARK: -
    // MARK: - Public Interface
    
    // MARK: -
    // MARK: - Private Interface
    
    private var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerClass(NotificationCell.self, forCellReuseIdentifier: CellIdentifiers.NotificationCellId)
            tableView.tableFooterView = UIView(frame: CGRectZero)
            tableView.separatorColor = .clearColor()
            
            view.addSubview(tableView)
        }
    }
    
    private var notifications: [Notification]! {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.startAnimating()
            activityIndicator.color = AppColor.darkBlueColor()
            activityIndicator.hidesWhenStopped = true
            view.addSubview(activityIndicator)
        }
    }
    
    // Simple cache system
    private var avatarImages = [Int: UIImage]()
    
    // MARK: -
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: -
    // MARK: - Override Base
    
    override func setupUI() {
        super.setupUI()
    
        /**
        Configuration
        */
        navigationItem.titleView = notificationTitleView()
        
        
        
        /**
        Initialization
        */
        tableView = UITableView()
        
        // Add Loading
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        view.bringSubviewToFront(activityIndicator)
        
        APIManager.GetNotifications({ (responseObject) -> Void in
            // Success
            // Set model
            self.notifications = responseObject
            self.activityIndicator.stopAnimating()
            }) { (error) -> Void in
                // Error
                print(error)
                self.activityIndicator.stopAnimating()
        }
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    override func clearUI() {
        super.clearUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        /**
        Layout && Geometry
        */
        tableView.frame = view.layer.bounds
        
        activityIndicator.frame = CGRect(x: view.frame.size.width / 2 - 25, y: view.frame.size.height / 2 - 25, width: 50, height: 50)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    // MARK: -
    // MARK: - Public Implementation

    // MARK: -
    // MARK: - Private Implementation
    
    /**
    Set custom title view to navigation item "Notifications"
    
    - returns: UILabel
    */
    private func notificationTitleView() -> UILabel {
        
        let notificationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: Basic.Size.Height.NavigationBarHeight))
        notificationLabel.text = "Notifications"
        notificationLabel.textColor = .whiteColor()
        notificationLabel.font = UIFont(name: Fonts.LatoBold, size: 20.0)
        notificationLabel.textAlignment = .Center
        
        return notificationLabel
    }
    
    var cellHeight: CGFloat = 0
    
    // MARK: -
    // MARK: - Actions && Selectors
    
    // MARK: - 
    // MARK: - UITableViewDelegate && UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications != nil ? self.notifications.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Create notification for row
        let notification = notifications[indexPath.row]
        
        // Get type
        var tempType = NotificationCellType()
        switch notification.type {
        case .PhotoLike, .MessageLike: tempType = .Post
        default: tempType = .Other
        }
        
        // Dummy implementation for showing self sizing cells
        
        if indexPath.row == 2 {
            let cell = NotificationCell(style: .Default, reuseIdentifier: CellIdentifiers.NotificationCellId, notificationCellType: .Comment)
            cell.textLabel?.text = notification.username
            cell.notificationType = "commented your post:"
            cell.time = notification.notificationDate
            cell.comment = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since."
            if notification.avatarImageURL == nil || notification.avatarImageURL?.characters.count == 0 { return cell }
            
            if let image = avatarImages[indexPath.row] {
                cell.imageView?.image = image
            } else {
                APIManager.getImageByUrl(notification.avatarImageURL!, completion: { (image) -> Void in
                    if image == nil { return }
                    self.avatarImages[indexPath.row] = image
                    cell.imageView!.image = image
                    cell.layoutSubviews()
                })
            }
            return cell
        }
        
        // Create cell
        let cell = NotificationCell(style: .Default, reuseIdentifier: CellIdentifiers.NotificationCellId, notificationCellType: tempType)
        
        // Set cell
        cell.textLabel?.text = notification.username
        cell.notificationType = notification.notificationTypeText!
        cell.time = notification.notificationDate

    
        if notification.avatarImageURL == nil || notification.avatarImageURL?.characters.count == 0 { return cell }

        if let image = avatarImages[indexPath.row] {
            cell.imageView?.image = image
        } else {
            APIManager.getImageByUrl(notification.avatarImageURL!, completion: { (image) -> Void in
                if image == nil { return }
                self.avatarImages[indexPath.row] = image
                cell.imageView!.image = image
                cell.layoutSubviews()
            })
        }
        return cell
    }
    
    private func getSizeForString(string: String) -> CGSize {
        return  NSString(string: string).sizeWithAttributes([NSFontAttributeName : UIFont(name: "Helvetica", size: 18)!])
    }
    
    func updateCellHeight(height: CGFloat, forRowAtIndexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // Dummy implementation for showing self sizing cells
        
        if indexPath.row == 2 {
            
            let stringWidth = LayoutManager.getWidthOfString("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the.", withFont: BaseRegularFont())
            let stringHeight = LayoutManager.getHeightOfString("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since.", withFont: BaseRegularFont())
            let lineNumbers = LayoutManager.getLinesForLabelForStringWidth(stringWidth, labelWidth: Basic.Size.Width.CommentLabelWidth)
            let cellHeight = Basic.Size.Height.NotificationCellDefaultHeight + (ceil(lineNumbers) * ceil(stringHeight))
            
            return  cellHeight

        } else {
            return  Basic.Size.Height.NotificationCellDefaultHeight
        }
    }
}
