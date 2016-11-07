//
//  TinderViewController.swift
//  TinderExample
//
//  Created by Kaustubh on 06/11/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

import Foundation
import UIKit

protocol TinderViewDelegate {
    
}

protocol TinderViewDataSource {
    func getNextCard() -> CardModel
}


class TinderViewController: UIViewController {
    
    private var currentCard: CardModel?
    private var nextCard: CardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        if ((currentCard) != nil){
            
        }
    }
    
    
}
