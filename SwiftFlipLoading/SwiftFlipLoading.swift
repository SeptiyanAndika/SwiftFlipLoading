//
//  SwiftFlipLoading.swift
//  flip
//
//  Created by Septiyan Andika on 11/1/16.
//  Copyright © 2016 Septiyan Andika. All rights reserved.
//   overlay view based on https://github.com/peterprokop/SwiftOverlays
//
import UIKit

class SwiftFlipLoading: NSObject {

   private var cardView: UIView!
   private var back: UIImageView!
   private var front: UIImageView!
   private var showingBack = true
    
   private var array: [String]!
   private var index:NSInteger = 1;
  
   private let padding = CGFloat(10)
   private var loading = false;
    
   private let delayInSeconds = 0.5
   
   private var dimview:UIView?;
    
   init(images array: [String]) {
        super.init()
        self.array = array
        self.flipView()
   }
    
    public func showLoading(parentView: UIView!){
        assert(parentView != nil, "`view` should have a superview")
        loading = true;
        dimview = UIView(frame: parentView.frame);
        self.dimview?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.showGenericOverlay(parentView: parentView, accessoryView: self.cardView)
        flip()
    }
    
    public func stopLoading(){
       loading = false;
       self.dimview?.removeFromSuperview();
       
    }
    
    private func flipView(){
        
        front = UIImageView(image: UIImage(named: array[0]))
        back = UIImageView(image: UIImage(named:  array[(array.count>1) ? 1 : 0]))
        let rect = CGRect(x:padding,  y:padding, width:(back.image?.size.width)!, height: (back.image?.size.height)!)
        cardView = UIView(frame: rect)
        cardView.isUserInteractionEnabled = true
        cardView.addSubview(back)

    }
    
     private func flip() {
        if(loading==false){
            return;
        }
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            let indexFront = self.index;
            var indexBack = self.index+1;
            if(indexBack >= self.array.count){
                indexBack = 0;
            }
            if (self.showingBack) {
                self.back.image=UIImage(named: self.array[indexFront]);
                self.front.image=UIImage(named: self.array[indexBack]);
                UIView.transition(from: self.back, to: self.front, duration: self.delayInSeconds, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
                self.showingBack = false
            } else {
                self.back.image=UIImage(named: self.array[indexBack]);
                self.front.image=UIImage(named: self.array[indexFront]);
                UIView.transition(from: self.front, to: self.back, duration: self.delayInSeconds, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
                self.showingBack = true
            }
            if(self.index >= self.array.count-1){
                self.index = 0;
                
            }else{
                self.index += 1;
            }
            self.flip();
            
        }
    }

    
     private func showGenericOverlay(parentView: UIView, accessoryView: UIView)  {
        var actualSize =  CGSize(width: 0, height: 0)
        
        
        actualSize = CGSize(width:  accessoryView.frame.size.width + padding * 2,
                            height: accessoryView.frame.size.height + padding * 2)
        
        
        
        let containerViewRect = CGRect(x:0,
                                       y:0,
                                       width:actualSize.width,
                                       height:actualSize.height)
        
        let containerView = UIView(frame: containerViewRect)
       
        
        containerView.layer.cornerRadius = CGFloat(10)
        containerView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
        containerView.center = CGPoint(x:parentView.bounds.size.width/2,
                                       y:parentView.bounds.size.height/2)
        
        containerView.addSubview(accessoryView)
        
        self.dimview?.addSubview(containerView);
        parentView.addSubview(self.dimview!)
 //       parentView.addSubview(containerView)
        
        Utils.centerViewInSuperview(view: containerView)
        
      
    }
    
    
    public class Utils {
        
        /**
         Adds autolayout constraints to innerView to center it in its superview and fix its size.
         `innerView` should have a superview.
         
         - parameter innerView: View to set constraints on
         */
        public static func centerViewInSuperview(view: UIView) {
            assert(view.superview != nil, "`view` should have a superview")
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let constraintH = NSLayoutConstraint(item: view,
                                                 attribute: NSLayoutAttribute.centerX,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: view.superview,
                                                 attribute: NSLayoutAttribute.centerX,
                                                 multiplier: 1,
                                                 constant: 0)
            let constraintV = NSLayoutConstraint(item: view,
                                                 attribute: NSLayoutAttribute.centerY,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: view.superview,
                                                 attribute: NSLayoutAttribute.centerY,
                                                 multiplier: 1,
                                                 constant: 0)
            let constraintWidth = NSLayoutConstraint(item: view,
                                                     attribute: NSLayoutAttribute.width,
                                                     relatedBy: NSLayoutRelation.equal,
                                                     toItem: nil,
                                                     attribute: NSLayoutAttribute.notAnAttribute,
                                                     multiplier: 1,
                                                     constant: view.frame.size.width)
            let constraintHeight = NSLayoutConstraint(item: view,
                                                      attribute: NSLayoutAttribute.height,
                                                      relatedBy: NSLayoutRelation.equal,
                                                      toItem: nil,
                                                      attribute: NSLayoutAttribute.notAnAttribute,
                                                      multiplier: 1,
                                                      constant: view.frame.size.height)
            view.superview!.addConstraints([constraintV, constraintH, constraintWidth, constraintHeight])
        }
    }
    
}
