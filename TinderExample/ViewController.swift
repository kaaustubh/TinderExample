//
//  ViewController.swift
//  TinderExample
//
//  Created by Kaustubh on 06/11/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CardViewDelegate {
    
    var cardViews: NSMutableArray!
    
    var currentIndex : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadInitialCards()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func loadInitialCards()
    {
        var newCard: CardModel
        var count: Int = 0
        self.currentIndex = count
        var cardView: CardView
        self.cardViews = NSMutableArray()
        while (count<3) {
            if (self.currentIndex % 2 == 0) {
                newCard = CardModel(cardid: count, image: ImageManager.sharedInstance.getRandomImage(), color: UIColor.green)
            }
            else{
                newCard = CardModel(cardid: count, image: ImageManager.sharedInstance.getRandomImage(), color: UIColor.blue)
            }
            
            count=count+1
            self.currentIndex = count
            cardView = CardView(frame: CGRect(x: (self.view.frame.size.width-350)/2, y: (self.view.frame.size.height - 300)/2, width: 350, height: 300))
            cardView.cardModel = newCard
            cardView.delegate = self
            
            self.cardViews.add(cardView)
        }
        
        count = 2;
        while(count >= 0)
        {
            self.view.addSubview(self.cardViews.object(at: count) as! UIView )
            count = count-1
        }
    }
    
    func cardSwipedRight()
    {
        print("Right Swiped")
        self.showNextCard()
        
    }
    
    func cardSwipedLeft()
    {
        print("Left Swiped")
        self.showNextCard()
    }
    
    
    
    func showNextCard() {
        
        let topView : CardView = self.cardViews.firstObject as! CardView
        self.cardViews.remove(topView as Any)
        self.cardViews.add(topView as Any)
        topView.alpha = 1.0
        
        
        var newCard: CardModel
        if (self.currentIndex%2 == 0) {
            newCard = CardModel(cardid: self.currentIndex, image: ImageManager.sharedInstance.getRandomImage(), color: UIColor.green)
        }
        else{
            newCard = CardModel(cardid: self.currentIndex, image: ImageManager.sharedInstance.getRandomImage(), color: UIColor.blue)
        }
        
        self.currentIndex = self.currentIndex + 1
        
        topView.cardModel = newCard
        
        
        self.view.insertSubview(self.cardViews.lastObject as! UIView, belowSubview: self.cardViews.object(at: 1) as! UIView)
    }
    
}

