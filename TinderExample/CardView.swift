//
//  CardView.swift
//  TinderExample
//
//  Created by Kaustubh on 06/11/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

import Foundation
import UIKit

protocol CardViewDelegate {
    func cardSwipedLeft()
    func cardSwipedRight()
}

class CardView: UIView {
    
    private var deltaX: CGFloat
    private var deltaY: CGFloat
    
    var delegate : CardViewDelegate?
    
    
    private let imageView: UIImageView
    
    var cardModel : CardModel?
    
    
    private var startPoint: CGPoint
    
    private let rotationMax: CGFloat = 1.0
    private let defaultRotationAngle = CGFloat(M_PI) / 10.0
    private let scaleMin: CGFloat = 0.8
    
    private var panGestureRecognizer : UIPanGestureRecognizer

    
    override init(frame: CGRect) {
        
        self.deltaX = 0.0
        self.deltaY = 0.0
        self.panGestureRecognizer = UIPanGestureRecognizer()
        self.imageView = UIImageView()
        self.startPoint = CGPoint(x: 0.0, y: 0.0)
        super.init(frame: frame)
        self.imageView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        self.panGestureRecognizer.addTarget(self, action: #selector(panGestureRecognized))
        self.addSubview(self.imageView)
        self.imageView.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = 4;
        self.layer.shadowRadius = 3;
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutSubviews()
    {
        self.imageView.image = self.cardModel?.image
        self.alpha = 1.0
    }
    

    func panGestureRecognized(gestureRecognizer: UIPanGestureRecognizer)
    {
        
        self.deltaX = (gestureRecognizer.translation(in: self).x)
        self.deltaY = (gestureRecognizer.translation(in: self).y)
        switch gestureRecognizer.state {
            case .began:
                self.startPoint = self.center
            case .changed:
                let rotationStrength : CGFloat = min(self.deltaX/self.frame.size.width , rotationMax)
                let rotationAngle: CGFloat = rotationStrength*defaultRotationAngle
                let scaleFactor : CGFloat = 1 - ((1 - scaleMin) * fabs(rotationStrength))
                let scale = max(scaleFactor, scaleMin)
                self.center = CGPoint(x: self.startPoint.x+self.deltaX, y: self.startPoint.y+self.deltaY)
            
                let afflineTransform : CGAffineTransform =  CGAffineTransform(rotationAngle: rotationAngle)
            
                let scaleTransform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
                self.transform = scaleTransform
            
        case .ended:
             self.swipeEnded()
            
        default:
            print("Rotation ended")
            
        }
    }
    
    func swipeEnded()
    {
        if(self.deltaX > 100)
        {
            self.rightSwiped()
        }
        else if(self.deltaX < -100)
        {
            self.leftSwiped()
        }
        else
        {
            UIView.animate(withDuration: 0.5, delay: 0.1, options: [.curveEaseOut], animations: {
                    self.center = self.startPoint
                self.transform = CGAffineTransform(rotationAngle: 0.0)
            }, completion: {(finished: Bool) -> Void in
                
            })
        }
    }
    
    func rightSwiped()  {
        let finishPoint : CGPoint = CGPoint(x: 500, y: 2*self.deltaY + self.startPoint.y)
        UIView.animate(withDuration: 0.2, delay: 0.1, options: [.curveEaseOut], animations: {
            self.center = finishPoint
        }, completion: {(finished: Bool) -> Void in
            
            self.alpha = 0.0
            self.center = self.startPoint
            self.transform = CGAffineTransform(rotationAngle: 0.0)
            self.delegate?.cardSwipedRight()
            //self.removeFromSuperview()
        })
    }
    
    func leftSwiped()  {
        let finishPoint : CGPoint = CGPoint(x: -500, y: 2*self.deltaY + self.startPoint.y)
        UIView.animate(withDuration: 0.2, delay: 0.1, options: [.curveEaseOut], animations: {
            self.center = finishPoint
        }, completion: {(finished: Bool) -> Void in
            
            self.alpha = 0.0
            self.center = self.startPoint
            self.transform = CGAffineTransform(rotationAngle: 0.0)
            self.delegate?.cardSwipedLeft()
        })
    }
    
    
    func rightSwipeTapped() {
        let finishPoint : CGPoint = CGPoint(x: 500, y: 2*self.deltaY + self.startPoint.y)
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseOut], animations: {
            self.center = finishPoint
            self.transform = CGAffineTransform(rotationAngle: 1.0)
        }, completion:
            {(finished: Bool) -> Void in
            
                self.alpha = 0.0
                self.center = self.startPoint
                self.transform = CGAffineTransform(rotationAngle: 0.0)
                self.delegate?.cardSwipedRight()
            }
        )
    }
    
    func leftSwipeTapped() {
        let finishPoint : CGPoint = CGPoint(x: -500, y: 2*self.deltaY + self.startPoint.y)
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseOut], animations: {
            self.center = finishPoint
            self.transform = CGAffineTransform(rotationAngle: -1.0)
        }, completion: {(finished: Bool) -> Void in
            
            self.alpha = 0.0
            self.center = self.startPoint
            self.transform = CGAffineTransform(rotationAngle: 0.0)
        })
    }
    
    
}
