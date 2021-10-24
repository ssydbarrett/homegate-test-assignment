//
//  FavoritesTableViewCell.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 24.10.21..
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    // MARK:
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var imgProperty: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    
    // MARK: - Properties
    // MARK:
    
    var context: BaseViewController!
    
    var model: PropertyModel!
    
    var indexPath: IndexPath!

    // MARK: - Configuration
    // MARK:
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        // Configure cell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Cell Initiation
    static func initCell(_ tableView: UITableView, itemAtIndexPath indexPath: IndexPath, params: NSDictionary?, context: BaseViewController) -> FavoritesTableViewCell {
        
        // Create item
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        
        // Set context and index path
        cell.context = context
        cell.indexPath = indexPath
        
        // Set Model
        cell.model = params?["model"] as? PropertyModel ?? PropertyModel()
        
        // Configure cell
        cell.configureCell()
        
        // Return cell
        return cell
    }

    // Handle cell configuration
    func configureCell() {
        
        // Configure Title label
        lblName.text = String(format: "%@%@%@%@%@",
                              model.title ?? "",
                              model.title == nil || model.title == "" || model.price == nil ? "" : ", ",
                              String(model.price ?? 0),
                              model.currency == nil || model.currency == "" ? "" : " ",
                              model.currency ?? "")
        
        // Configure Arrow icon
        let templateImage = imgArrow.image?.withRenderingMode(.alwaysTemplate)
        imgArrow.image = templateImage
        imgArrow.tintColor = .label
        
        // Configure image placeholder
        imgProperty.image = UIImage(named: "ic-image-placeholder")?.withRenderingMode(.alwaysTemplate)
        imgProperty.contentMode = .scaleAspectFill
        imgProperty.backgroundColor = .separator
        imgProperty.tintColor = .label
        imgProperty.layer.cornerRadius = 4.0
        imgProperty.layer.masksToBounds = true
        
        // Get Picture URL
        var imageUrlString: String = ""
        if model.getClearedPicFilename1Medium() != nil && model.getClearedPicFilename1Medium() != "" {
            imageUrlString = model.getClearedPicFilename1Medium() ?? ""
        } else if model.getClearedPicFilename1() != nil && model.getClearedPicFilename1() != "" {
            imageUrlString = model.getClearedPicFilename1() ?? ""
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
}
