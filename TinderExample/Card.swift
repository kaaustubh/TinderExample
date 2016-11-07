//
//  Card.swift
//  TinderExample
//
//  Created by Kaustubh on 06/11/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

import Foundation
import UIKit


class CardModel
{
    var id: Int
    var image: UIImage?
    var color: UIColor
    
    init(cardid: Int , image: UIImage?, color: UIColor) {
        self.id  = cardid
        self.image = image
        self.color = color
    }
}
