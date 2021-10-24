//
//  PropertyListTableViewCell.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 24.10.21..
//

import UIKit

class PropertyListTableViewCell: UITableViewCell {

    // MARK: - Outlets
    // MARK:
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var imgProperty: UIImageView!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var imgPriceBackground: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    
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
        
    }
    
    // MARK: Cell actions
}
