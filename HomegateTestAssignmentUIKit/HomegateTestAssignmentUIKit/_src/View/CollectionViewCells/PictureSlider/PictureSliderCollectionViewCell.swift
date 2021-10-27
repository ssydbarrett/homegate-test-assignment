//
//  PictureSliderCollectionViewCell.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 27.10.21..
//

import UIKit
import SDWebImage

class PictureSliderCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    // MARK:
    
    @IBOutlet weak var imgProperty: UIImageView!
    @IBOutlet weak var imgPropertyPlaceholder: UIImageView!
    @IBOutlet weak var constraintImgPropertyWidth: NSLayoutConstraint!
    
    // MARK: - Properties
    // MARK:
    
    var params: Dictionary<String, Any>!
    
    var url: String!
    
    var context: HomeDetailsViewController!
    
    // MARK: - Configuration
    // MARK:
    
    // Drawing code
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
 
    // Configure cell
    static func initItem(_ collectionView: UICollectionView, itemAtIndexPath indexPath: IndexPath, params: Dictionary<String, Any>, context: HomeDetailsViewController) -> PictureSliderCollectionViewCell {
        
        // Create item
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureSliderCollectionViewCell", for: indexPath) as! PictureSliderCollectionViewCell
        
        // Set context & params
        item.context = context
        item.url = params["url"] as? String ?? ""
        
        // Configure cell
        item.backgroundColor = .clear
        item.contentView.backgroundColor = .clear
        
        // Update constraint to match device width
        item.constraintImgPropertyWidth.constant = Utils.getScreenSize().width
        
        // Configure image placeholder
        item.imgPropertyPlaceholder.image = UIImage(named: "ic-image-placeholder")?.withRenderingMode(.alwaysTemplate)
        item.imgPropertyPlaceholder.contentMode = .center
        item.imgPropertyPlaceholder.backgroundColor = .separator
        item.imgPropertyPlaceholder.tintColor = .label
        
        // Load image via SDWebImage
        guard let imageUrl = URL(string: item.url) else { return item }
        item.imgProperty.sd_setHighlightedImage(with: imageUrl, options: .progressiveLoad) { image, error, cacheType, url in
        
            // Set image if not nil
            if image != nil {
                item.imgProperty.image = image
                item.imgProperty.contentMode = .scaleAspectFill
                item.imgProperty.backgroundColor = .clear
            }
        }
        
        // Return item
        return item
    }
}
