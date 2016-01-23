/**
 * Usually i'm working with libraries such as AFNetworking or Alaofire.
*/

import UIKit

class APIManager: NSObject {
    
    /**
     Get all notification
     */
    class func GetNotifications(success: (responseObject: [Notification]) -> Void, failure: (NSError!) -> Void) {
        
        let URL = NSURL(string: NOTIFICATION_URL)
        
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            var error: NSError?
            
            do {
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
                
                // Success
                
                // Create notification array
                var notifications = [Notification]()

                for notification in jsonData.valueForKey("notifications") as! NSArray {
                    notifications.append(Notification(notificationData: notification as! NSDictionary))
                }
                
                // Callback with notifications array
                success(responseObject: notifications)
                
            } catch let e as NSError{
                // Error
                error = e
                failure(error!)
            }
        }
        task.resume()
    }
    
    // Download images
    class func getImageByUrl(imageURL: String, completion: (image: UIImage?) -> Void) {
        
        let escapedString = imageURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let URL = NSURL(string: escapedString!)
        
        let callerQueue = dispatch_get_main_queue()
        let downloadQueue = dispatch_queue_create("imageDownloadQueue", nil)
        
        dispatch_async(downloadQueue) { () -> Void in
            if URL == nil { print("Fail to download from URL :", URL); return }
            let imageData = NSData(contentsOfURL: URL!)
            dispatch_async(callerQueue, { () -> Void in
                if imageData != nil {
                    let image = UIImage(data: imageData!)
                    completion(image: image!)
                } else {
                    completion(image: nil)
                }
            })
        }
    }

}
