//
//  HelperImages.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class HelperImages {
    
    static let sharedInstance: HelperImages = HelperImages()
    var cache: NSCache<AnyObject, AnyObject> = NSCache()
    let imageClient: RestHandler = RestHandler()
    
    func getImage( url: URL, success: @escaping (_ image: UIImage) -> Void, fail: @escaping () -> Void) {
        
        if  let image: UIImage = self.cache.object(forKey: url as AnyObject) as? UIImage  {
            
            DispatchQueue.main.async {
                
                success(image)
            }
        } else {
            
            self.imageClient.get(url: url, onSuccess: { (data: Data) in
                
                if let image: UIImage = UIImage(data: data) {
                    
                    self.cache.setObject(image as AnyObject, forKey: url as AnyObject)
                    DispatchQueue.main.async {
                        
                        success(image)
                    }
                } else {
                    
                    DispatchQueue.main.async {
                        
                        fail()
                    }
                }
            }, onError: {
                
                DispatchQueue.main.async {
                    
                    fail()
                }
            })
        }
    }
}
