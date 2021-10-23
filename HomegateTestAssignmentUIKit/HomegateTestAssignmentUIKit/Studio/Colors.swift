//
//  Colors.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 23.10.21..
//

import UIKit

// Colors
struct Color {
    
    // Background
    static let backgroundWhite = UIColor.init(netHex: 0xFFFFFF)
    
    // Foreground
    static let foregroundBlack = UIColor.init(netHex: 0x253540)
    static let foregroundGrey = UIColor.init(netHex: 0x848587)
    static let foregroundPurple = UIColor.init(netHex: 0xADAEB0)
    
    // Icon
    static let iconRed = UIColor.init(netHex: 0xF60C0C)
}

// MARK: - UIColor Extensions
// MARK:

// Extension for UIColor
extension UIColor {
    
    // Set color using RGB params
    convenience init(red: Int, green: Int, blue: Int, alphaFloat: CGFloat) {
        assert(red   >= 0 && red   <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue  >= 0 && blue  <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alphaFloat)
    }
    
    // Set color as 0xff88ro
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, alphaFloat: 1.0)
    }
    
    // Set color as 0xff88ro
    convenience init(netHex:Int, alpha: CGFloat) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, alphaFloat: alpha)
    
    }
}
