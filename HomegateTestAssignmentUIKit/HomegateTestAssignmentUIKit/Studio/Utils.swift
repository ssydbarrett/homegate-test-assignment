//
//  Utils.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 23.10.21..
//

import UIKit

class Utils: NSObject {

    // MARK: - Configuration
    // MARK:
    
    // Configure label
    static func configureLabel(label: UILabel, text: String?, font: UIFont?, textColor: UIColor?) {
        
        // Set text
        if (text != nil) {
            label.text = text
        }
        
        // Set font
        if (font != nil) {
            label.font = font
        }
        
        // Set text color
        if (textColor != nil) {
            label.textColor = textColor;
        }
    }
    
    // Configure button
    static func configureButton(button: UIButton, title: String?, font: UIFont?, titleColor: UIColor?, titleColorHighlighted: UIColor?, backgroundImage: String?) {
        
        // Set text
        if (title != nil) {
            button.setTitle(title, for: .normal)
            button.setTitle(title, for: .highlighted)
            button.setTitle(title, for: .selected)
        }
        
        // Set font
        if (font != nil) {
            button.titleLabel?.font = font
        }
        
        // Set title color
        if (titleColor != nil) {
            button.setTitleColor(titleColor, for: .normal)
            if (titleColorHighlighted != nil) {
                button.setTitleColor(titleColorHighlighted, for: .highlighted)
                button.setTitleColor(titleColorHighlighted, for: .selected)
            } else {
                button.setTitleColor(titleColor, for: .highlighted)
                button.setTitleColor(titleColor, for: .selected)
            }
        }
        
        // Set background image
        if (backgroundImage != nil) {
            let inactiveImage = UIImage(named: String(format: "%@", backgroundImage!)) // "%@_inactive"
            let activeImage = UIImage(named: String(format: "%@", backgroundImage!)) // "%@_active"
            button.setBackgroundImage(inactiveImage,/*?.resizableImage(withCapInsets: UIEdgeInsetsMake(40, 40, 40, 40)),*/ for: .normal)
            button.setBackgroundImage(activeImage,/*?.resizableImage(withCapInsets: UIEdgeInsetsMake(40, 40, 40, 40)),*/ for: .highlighted)
            button.setBackgroundImage(activeImage,/*?.resizableImage(withCapInsets: UIEdgeInsetsMake(40, 40, 40, 40)),*/ for: .selected)
        }
    }
    
    // Configure UITextField
    static func configureTextField(txtField: UITextField, text: String?, placeholder: String?, font: UIFont?, textColor: UIColor?, backgroundImage: String?, leftPadding: CGFloat, rightPadding: CGFloat) {
        
        // Set text
        if (text != nil) {
            txtField.text = text
        }
        
        // Set placeholder
        if (placeholder != nil) {
            txtField.placeholder = placeholder
        }
        
        // Set font
        if (font != nil) {
            txtField.font = font
        }
        
        // Set text color
        if (textColor != nil) {
            txtField.textColor = textColor;
        }
        
        // Set background image
        if (backgroundImage != nil) {
            let imgBackground = UIImage(named: backgroundImage!)
            txtField.background = imgBackground/*?.resizableImageWithCapInsets(UIEdgeInsetsMake(40, 40, 40, 40))*/
        }
        
        // Set left padding
        if (leftPadding != 0) {
            let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: leftPadding, height: leftPadding))
            txtField.leftView = paddingView;
            txtField.leftViewMode = .always;
        }
        
        // Set right padding
        if (rightPadding != 0) {
            let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: rightPadding, height: rightPadding))
            txtField.rightView = paddingView;
            txtField.rightViewMode = .always;
        }
        
    }
    
    // Configure UITextView
    static func configureTextView(txtView: UITextView, text: String?, font: UIFont?, textColor: UIColor?) {
        
        // Set text
        if (text != nil) {
            txtView.text = text
        }
        
        // Set font
        if (font != nil) {
            txtView.font = font
        }
        
        // Set text color
        if (textColor != nil) {
            txtView.textColor = textColor;
        }
    }
    
    // Redraw constraints on view controller
    static func redrawConstraints(viewController: UIViewController) {
        viewController.view.setNeedsLayout()
        viewController.view.setNeedsDisplay()
        viewController.view.layoutIfNeeded()
        viewController.view.layoutSubviews()
        viewController.viewDidLayoutSubviews()
    }
    
    // MARK: - UIView
    // MARK:
    
    // Add shadow to view
    static func addShadowTo(view: UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 1
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.masksToBounds = false
    }
    
    // Add border to view
    static func addBorderTo(view: UIView, cornerRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat? = nil) {
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = borderWidth ?? 1.0
        view.layer.borderColor = borderColor.cgColor
        view.layer.masksToBounds = true
    }
    
    // MARK: - OS
    // MARK:
    
    // Get screen size
    static func getScreenSize() -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    // Check if iphone or ipad
    static func isIphone() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return true
        } else {
            return false
        }
    }
    
    // Check if top noch is available
    static func hasTopNotch() -> Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // with notch: 44.0 on iPhone X, XS, XS Max, XR.
            // without notch: 24.0 on iPad Pro 12.9" 3rd generation, 20.0 on iPhone 8 on iOS 12+.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 24
        }
        return false
    }
    
    // MARK: - Alert View Controller
    // MARK:
    
    // Show modal message
    static func showModalMessage(title: String, message: String, context: UIViewController, handler: ((UIAlertAction) -> Void)?) {
        
        // Create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // Add an action
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            if handler != nil {
                handler!(action)
            }
        }))
        
        // Show the alert
        context.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Share
    // MARK:
    
    // Share content
    static func share(text: String?, url: String?, image: UIImage?, context: UIViewController) {
        
        // Create activity items
        var activityItems = [Any]()
        
        // Set image for share
        if image != nil {
            let imgData = image!.png
            activityItems.append(UIImage(data: imgData ?? Data(), scale: 1.0) as AnyObject)
        }
        
        // Set text for share
        if text != nil && text != "" {
            activityItems.append(text! as AnyObject)
        }
        
        // Set url for share
        if url != nil && url != "" {
            activityItems.append(url! as AnyObject)
        }

        // Create activity view controller
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            // UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
        
        // Present share vindow
        context.present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - Logging
// MARK:

// Log state
struct LogState {
    static let logConstant = "Log"
    static let logConstantNot = "LogNot"
}

extension Utils {
    
    // Log function
    static func log(string: AnyObject) {
        if LogState.logConstant == "LogNot" {
            print(string)
        }
    }
    
    // Log all fonts
    static func printFonts() {
        for family in UIFont.familyNames {
            print("\(family)")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
}

