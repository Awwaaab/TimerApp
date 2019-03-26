//
//  mycustomview.swift
//  timerApp
//
//  Created by Awab Aly-mac on 7/5/18.
//  Copyright © 2018 MY_O. All rights reserved.
//

import UIKit

@IBDesignable
class mycustomview: UIView {
    
    @IBInspectable var FirstColoR : UIColor = UIColor.clear {didSet{updateViewCOLOR()}}
    @IBInspectable var SecondColoR : UIColor  = UIColor.clear {didSet{updateViewCOLOR()}}
    @IBInspectable var conerRADius:CGFloat = 0 {didSet{self.layer.cornerRadius=conerRADius}}
    override class var layerClass:AnyClass {get{return CAGradientLayer.self}}
    func updateViewCOLOR() {
    let Layer=self.layer as! CAGradientLayer
        Layer.colors=[FirstColoR.cgColor,SecondColoR.cgColor]
    }
        
}
