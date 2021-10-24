//
//  PropertyListTableViewCell.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 24.10.21..
//

import UIKit
import SDWebImage

class PropertyListTableViewCell: UITableViewCell {

    // MARK: - Outlets
    // MARK:
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgProperty: UIImageView!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var imgPriceBackground: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgLocationMarker: UIImageView!
    @IBOutlet weak var lblStreet: UILabel!
    
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
    static func initCell(_ tableView: UITableView, itemAtIndexPath indexPath: IndexPath, params: NSDictionary?, context: BaseViewController) -> PropertyListTableViewCell {
        
        // Create item
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyListTableViewCell", for: indexPath) as! PropertyListTableViewCell
        
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
        
        // Configure content
        Utils.addBorderTo(view: viewContent, cornerRadius: 4.0, borderColor: .separator, borderWidth: 1.0)
        
        // Configure favorite button
        btnFavorite.backgroundColor = UIColor.clear
        var templateImage = btnFavorite.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
        btnFavorite.setImage(templateImage, for: .normal)
        templateImage = btnFavorite.image(for: .selected)?.withRenderingMode(.alwaysTemplate)
        btnFavorite.setImage(templateImage, for: .selected)
        btnFavorite.tintColor = Color.iconRed
        
        // Configure Price view and label
        templateImage = imgPriceBackground.image?.withRenderingMode(.alwaysTemplate)
        imgPriceBackground.image = templateImage
        imgPriceBackground.tintColor = Color.foregroundPurple
        lblPrice.text = String(format: "%@%@%@",
                               String(model.price ?? 0),
                               model.currency == nil || model.currency == "" ? "" : " ",
                               model.currency ?? "")
        
        // Configure Title label
        lblName.text = model.title ?? "Missing title"
        
        // Configure street icon and
        templateImage = imgLocationMarker.image?.withRenderingMode(.alwaysTemplate)
        imgLocationMarker.image = templateImage
        imgLocationMarker.tintColor = Color.foregroundPurple
        lblStreet.text = String(format: "%@%@%@",
                                model.street ?? "",
                                model.street == nil || model.street == "" || model.text == nil || model.text == "" ? "" : ", ",
                               model.text ?? "")
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
    
    // MARK: Cell actions
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
}
