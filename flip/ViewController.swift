//
//  ViewController.swift
//  flip
//
//  Created by Septiyan Andika on 11/1/16.
//  Copyright © 2016 Septiyan Andika. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var loadingView:SwiftFlipLoading?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadingView = SwiftFlipLoading(images: ["1","2","3","4"]);
       
        //view.addSubview(cardView)
        
       
    }
    
    
    @IBAction func showLoading(_ sender: Any) {
         loadingView?.showLoading(parentView: self.view);
        
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 15) {
            self.loadingView?.stopLoading()
        }
    }
        
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    

}

