//
//  BaseNavController.swift
//  YourLocal
//
//  Created by Dimitar Kostov on 1/19/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

class BaseNavController: UINavigationController {
    
    // MARK: -
    // MARK: - Public Interface
    
    // MARK: -
    // MARK: - Private Interface
    
    // MARK: -
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: -
    // MARK: - Override Base
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        DLOG("Memory leak in \(self.description)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Set navigationBar image
        navigationBar.setBackgroundImage(self.navigationBarImage(), forBarMetrics: UIBarMetrics.Default)
    }
    
    // MARK: -
    // MARK: - Public Implementation
    
    // MARK: -
    // MARK: - Private Implementation
    
    /**
    Creates horizontal gradient layer with application main blue and green colors
    
    - returns: CAGradientLayer
    */
    private func gradientLayer() -> CAGradientLayer {
        
        // Create and allocate gradient layer.
        let gradientLayer = CAGradientLayer()
        // Set frame.
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: Basic.Size.Height.NavigationBarAndStatusBarHeight)
        // Set colors.
        gradientLayer.colors = [AppColor.blueColor().CGColor, AppColor.greenColor().CGColor]
        // Make it horizontal.
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        return gradientLayer
    }
    
    /**
     Create UIImage object from CAGradientLayer object
    
     - returns: UIImage
     */
    private func navigationBarImage() -> UIImage {
        
        // Create gradient layer
        let gradientLayer = self.gradientLayer()
        
        // Create image with size.
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        // Render gradient to UIImage.
        gradientLayer.renderInContext(UIGraphicsGetCurrentContext()!)
        // Get image from current context.
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // End context.
        UIGraphicsEndImageContext()
        
        return image
    }
    
    // MARK: -
    // MARK: - Actions && Selectors

}
