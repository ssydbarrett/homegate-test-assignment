//
//  HomeListView.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 25.10.21..
//

import UIKit

class HomeListView: UIView {
    
    // MARK: Outlets
    
    @IBOutlet weak var tblTable: UITableView!
    
    // MARK: Properties
    
    var context: HomeViewController!
    
    // MARK: Creation
    
    // MARK: Configuration

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func configureListView() {
        
        // Init table view and set delegate
        if self.tblTable != nil {
            self.tblTable.delegate = self
            self.tblTable.dataSource = self
            
            // Regster table cell
            registerCellsForTableView()
        }
        
        // Clear content inset of a table view
        self.tblTable.contentInset = UIEdgeInsets(top: 8.0, left: 0, bottom: 24, right: 0)
        
        // Hide table view initially
        self.tblTable.alpha = 0.0
    }
}

// MARK: - Register cells
// MARK:

extension HomeListView {
    
    // Register vehicle cell
    func registerCellsForTableView() {
        let nibName = UINib(nibName: "PropertyListTableViewCell", bundle:nil)
        self.tblTable.register(nibName, forCellReuseIdentifier: "PropertyListTableViewCell")
    }
}

// MARK: - UITableViewDelegate
// MARK:

extension HomeListView: UITableViewDelegate {
    
    // Estimated cell height
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Cell height for row at index path
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Height for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    // Header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // Open details view controller on cell tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get model from a cell
        let cell = tableView.cellForRow(at: indexPath) as? PropertyListTableViewCell ?? PropertyListTableViewCell()
        let model = cell.model
        let isFavorite = cell.isFavorite
        
        // Route to details
        self.context.router?.routeToDetailsViewController(params: ["model": model ?? PropertyModel(), "isFavorite": isFavorite ?? false])
    }
}

// MARK: - UITableViewDatasource
// MARK:

extension HomeListView: UITableViewDataSource {
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.context.propertyList.count
    }
    
    // Cell For Row at IndexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create cell
        let cell = PropertyListTableViewCell.initCell(
            tableView,
            itemAtIndexPath: indexPath,
            params: ["model": self.context.propertyList[indexPath.row],
                     "isFavorite": self.context.favoriteIdList.contains(self.context.propertyList[indexPath.row].advertisementId ?? -666)],
            context: self.context)
        
        // Add delegate
        cell.delegate = self
        
        // Return cell
        return cell
    }
}

// MARK: Implement Property list delegate with update favorite action

extension HomeListView: PropertyListTableViewCellDelegate {
    
    // Update favorite
    func updateFavorite(model: PropertyModel) {
        self.context.updateFavorite(model: model)
    }
}
