//
//  MapView.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/10/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    // MARK: Properties
    
    // constants for styling and configuration
    let darkerBlue = UIColor(red: 66/255, green: 116/255, blue: 185/255, alpha:1.0)
    let lighterBlue = UIColor(red: 0.0, green:0.502, blue:0.839, alpha: 1.0)
    
    // MARK: Initialization
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        themeButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        themeButton()
    }
    
    private func themeButton() {
        //layer.masksToBounds = true
        layer.cornerRadius = 5.0
        backgroundColor = darkerBlue
        //setTitleColor(.white, for: UIControlState())
        //titleLabel?.font = UIFont.systemFont(ofSize: titleLabelFontSize)
    }
}

class CustomTextField: UITextField {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        themeText()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        themeText()
    }
    
    private func themeText(){
        backgroundColor = .clear
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
    }

}
