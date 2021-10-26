//
//  GoogleMapsInfoView.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 26.10.21..
//

import UIKit

class GoogleMapsInfoView: UIView {
    
    // MARK: - Outlets
    // MARK:
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var imgProperty: UIImageView!
    
    @IBOutlet weak var btnFavorite: UIButton!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStreet: UILabel!

    // MARK: - Properties
    // MARK:
    
    var model: PropertyModel!
    var context: HomeViewController!

    // MARK: - Creation
    // MARK:
    
    class func createGMInfoView(y: CGFloat, model: PropertyModel, context: HomeViewController) -> GoogleMapsInfoView {
        
        // Init game tc view from NIB
        let gmInfoView = Bundle.main.loadNibNamed("GoogleMapsInfoView", owner: nil, options: nil)![0] as! GoogleMapsInfoView
        gmInfoView.frame = CGRect(x: 16.0, y: y, width: Utils.getScreenSize().width - 32.0, height: 120.0)
        
        // Update params
        gmInfoView.model = model
        gmInfoView.context = context
        
        // Configure info view
        gmInfoView.configureView()
        
        // Return newly created view
        return gmInfoView
    }
    
    // Configuration
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // Configure view
    func configureView(alpha: CGFloat = 0.0) {
        
        // Hide initially
        self.alpha = alpha
        
        // Configure content
        Utils.addBorderTo(view: viewContent, cornerRadius: 4.0, borderColor: .separator, borderWidth: 1.0)
        
        // Configure favorite button
        btnFavorite.backgroundColor = UIColor.clear
        var templateImage = btnFavorite.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
        btnFavorite.setImage(templateImage, for: .normal)
        templateImage = btnFavorite.image(for: .selected)?.withRenderingMode(.alwaysTemplate)
        btnFavorite.setImage(templateImage, for: .selected)
        btnFavorite.tintColor = Color.iconRed
        
        // Set if favorite
        self.updateFavoriteStatus()
        
        // Configure Price view and label
        lblPrice.text = String(format: "%@%@%@",
                               String(model.price ?? 0),
                               model.currency == nil || model.currency == "" ? "" : " ",
                               model.currency ?? "")
        
        // Configure Title label
        lblName.text = model.title ?? "Missing title"
        
        // Configure street label 
        lblStreet.text = String(format: "%@%@%@",
                                model.street ?? "",
                                model.street == nil || model.street == "" || model.city == nil || model.city == "" ? "" : ", ",
                               model.city ?? "")
        lblStreet.textColor = Color.foregroundPurple
        
        // Configure image placeholder
        imgProperty.image = UIImage(named: "ic-image-placeholder")?.withRenderingMode(.alwaysTemplate)
        imgProperty.contentMode = .center
        imgProperty.backgroundColor = .separator
        imgProperty.tintColor = .label
        
        // Get Picture URL
        var imageUrlString: String = ""
        if model.getClearedPictures().count >= 1 {
            imageUrlString = model.getClearedPictures()[0] ?? ""
        } else if model.getClearedPicFilename1() != nil && model.getClearedPicFilename1() != "" {
            imageUrlString = model.getClearedPicFilename1() ?? ""
        } else if model.getClearedPicFilename1Medium() != nil && model.getClearedPicFilename1Medium() != "" {
            imageUrlString = model.getClearedPicFilename1Medium() ?? ""
        } else {
            imageUrlString = model.getClearedPicFilename1Small() ?? ""
        }
        
        // And last but not the least, Load image via SDWebImage
        guard let imageUrl = URL(string: imageUrlString) else { return }
        imgProperty.sd_setHighlightedImage(with: imageUrl, options: .progressiveLoad) { image, error, cacheType, url in
        
            // Set image if not nil
            if image != nil {
                self.imgProperty.image = image
                self.imgProperty.contentMode = .scaleAspectFill
                self.imgProperty.backgroundColor = .clear
            }
        }
    }
    
    // Update favorite
    func updateFavoriteStatus() {
        self.btnFavorite.isSelected = self.context.favoriteIdList.contains(self.model.advertisementId ?? -666)
    }
    
    // Update favorite status
    
    // MARK: - Button actions
    // MARK:
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        context.updateFavorite(model: self.model)
    }
}
