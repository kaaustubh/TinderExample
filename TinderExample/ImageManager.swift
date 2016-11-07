//
//  ImageManager.swift
//  TinderExample
//
//  Created by Kaustubh on 07/11/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

import Foundation
import UIKit

class ImageManager: NSObject {
    
fileprivate let imageArray = ["camera.png","chair.png","cupboard.png","laptop.png","light.png","mobile.png", "table.png"]
    
    class var sharedInstance: ImageManager {
        //2
        struct Singleton {
            //3
            static let instance = ImageManager()
           
        }
        //4
        return Singleton.instance
    }
    
    func getRandomImage() -> UIImage {
        let image: UIImage
        let randomIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
        image = UIImage(named: imageArray[randomIndex])!
        
        return image
    }
    
}

