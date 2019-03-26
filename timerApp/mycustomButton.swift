//  AppDelegate.swift
//  timerApp
//
//  Created by Awab Aly-mac on 7/5/18.
//  Copyright © 2018 MY_O. All rights reserved.
import UIKit
@IBDesignable
class mycustomButton: UIButton {
    @IBInspectable var borderWIDTH:CGFloat=0 {didSet{self.layer.borderWidth = borderWIDTH}}
    @IBInspectable var borderCOlOR:UIColor=UIColor.clear {
        didSet{self.layer.borderColor = borderCOlOR.cgColor }}
    @IBInspectable var cornerRAdios:CGFloat=0 {didSet{self.layer.cornerRadius=cornerRAdios}}
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds=true
        
    }
    }
    








