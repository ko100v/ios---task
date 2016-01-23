//
//  BaseController.swift
//  YourLocal
//
//  Created by Dimitar Kostov on 1/19/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    // MARK: -
    // MARK: - Public Interface
    
    // MARK: -
    // MARK: - Private Interface
    
    // MARK: -
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.clearUI()

    }

    // MARK: -
    // MARK: - Override Base
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        DLOG("Memory leak in \(self)")
    }
    
    // MARK: -
    // MARK: - Public Implementation
    
    /****  Abstraction ****/
    
    /**
    Initialization && Configuration
    */
    internal func setupUI() {
        // Allocate objects in memory, or customize self
        view.backgroundColor = .whiteColor()
        
        // White status bar
        setNeedsStatusBarAppearanceUpdate()
    }
    
    /**
     Update user interface
     */
    internal func updateUI() {
        // Update user interface by event or second show
    }
    
    /**
     Clear user interface
     */
    internal func clearUI() {
        // Clear user interface elements, realise memory objects, images, models.
    }
    
    // MARK: -
    // MARK: - Private Implementation
    
    // MARK: -
    // MARK: - Actions && Selectors
}
