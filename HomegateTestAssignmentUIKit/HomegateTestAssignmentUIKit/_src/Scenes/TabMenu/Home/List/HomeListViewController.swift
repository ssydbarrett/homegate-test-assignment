//
//  HomeListViewController.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 23.10.21..
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeListDisplayLogic: AnyObject
{
    
    // Display Properties lists from API
    func displayPropertyList(viewModel: HomeList.PropertyList.ViewModel)
    func displayPropertyListAPIError(error: HomeList.PropertyList.Error)
    
    // Display Favorite IDS list from Core Data
    func displayFavoriteList(viewModel: HomeList.FavoriteList.ViewModel)
    func displayFavoriteListError(error: HomeList.FavoriteList.Error)
}

class HomeListViewController: BaseViewController, HomeListDisplayLogic
{

    var interactor: HomeListBusinessLogic?
    var router: (NSObjectProtocol & HomeListRoutingLogic & HomeListDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = HomeListInteractor()
        let presenter = HomeListPresenter()
        let router = HomeListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var tblTable: UITableView!
    
    @IBOutlet weak var viewEmptyError: UIView!
    @IBOutlet weak var lblEmptyError: UILabel!
    @IBOutlet weak var btnTryAgain: UIButton!
    
    // MARK: Properties
    
    var propertyList: [PropertyModel] = [PropertyModel]()
    var favoriteIdList: [Int] = [Int]()
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Configure view
        configureView()
        
        // Get favorites
        self.fetchFavoritesIds()
        
        // Call API
        callAPI()
    }
    
    // Configure view
    func configureView() {
        
        // Init table view and set delegate
        if self.tblTable != nil {
            self.tblTable.delegate = self
            self.tblTable.dataSource = self
            
            // Regster table cell
            registerCellsForTableView()
        }
        
        // Clear content inset of a table view
        self.tblTable.contentInset = UIEdgeInsets(top: -16.0, left: 0, bottom: 24, right: 0)
    }
    
    
    // Handle empty / error view
    func displayEmptyErrorView(with label: String, and alpha: CGFloat) {
        
        // Show / hide empty / error view and show table based on alpha
        self.viewEmptyError.alpha = alpha
        self.tblTable.alpha = alpha == 0.0 ? 1.0 : 0.0
        
        // Send subview to front / back
        if alpha == 0.0 {
            self.view.sendSubviewToBack(self.viewEmptyError)
        } else {
            self.view.bringSubviewToFront(self.viewEmptyError)
        }
        
        // Set label
        self.lblEmptyError.text = label
    }
    
    // MARK: API
    
    // Call API
    func callAPI() {
        
        // Hide empty view
        self.displayEmptyErrorView(with: "", and: 0.0)
        
        // Start activity indicator
        self.startActivityIndicator(onView: nil, color: .label)
        
        // Call interactor
        self.interactor?.handlePropertyList(request: HomeList.PropertyList.Request())
    }
    
    // Fetch favorites ids
    @objc func fetchFavoritesIds() {
        self.interactor?.handleFavoriteList(request: HomeList.FavoriteList.Request())
    }
    
    // MARK: Button actions
    
    // Handle try again action
    @IBAction func tryAgain(_ sender: UIButton) {
        
        // Call API again
        self.callAPI()
    }
    
    // MARK: Display api result
    
    func displayPropertyList(viewModel: HomeList.PropertyList.ViewModel) {
        
        // On main thread
        DispatchQueue.main.async {
            
            // Stop activity indicator
            self.stopActivityIndicator()
            
            // Check if empty model
            if viewModel.proppertyList.count == 0 {
                
                // Clear model
                self.propertyList = [PropertyModel]()
                
                // Show error view
                self.displayEmptyErrorView(with: "Property list is empty.", and: 1.0)
                return
            }
            
            // Hide error view
            else {
                self.displayEmptyErrorView(with: "", and: 0.0)
            }
            
            // Update model and reload table
            self.propertyList = viewModel.proppertyList
            self.tblTable.reloadData()
        }
    }
    
    func displayPropertyListAPIError(error: HomeList.PropertyList.Error) {
        
        // On main thread
        DispatchQueue.main.async {
            
            // Stop activity indicator
            self.stopActivityIndicator()
            
            // Clear model
            self.propertyList = [PropertyModel]()
            
            // Show error view
            self.displayEmptyErrorView(with: error.error.rawValue, and: 1.0)
        }
    }
    
    // MARK: Display Core data result
    
    func displayFavoriteList(viewModel: HomeList.FavoriteList.ViewModel) {
        
        // Update favorite list
        self.favoriteIdList = viewModel.favoriteIdList
        
        // Reload table on main queue
        DispatchQueue.main.async {
            self.tblTable.reloadData()
        }
    }
    
    func displayFavoriteListError(error: HomeList.FavoriteList.Error) {
        
        // Print error
        print(error.error.localizedDescription)
        
        // Clear favorite list
        self.favoriteIdList = [Int]()
        
        // Reload table on main queue
        DispatchQueue.main.async {
            self.tblTable.reloadData()
        }
    }
    
    // MARK: - Notification handling
    // MARK:
    
    override func registerForNotifications() {
        super.registerForNotifications()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchFavoritesIds), name: CoreDataManager.notification_favorites_updated, object: nil)
    }
    
    override func unregisterForNotifications() {
        NotificationCenter.default.removeObserver(self, name: CoreDataManager.notification_favorites_updated, object: nil)
        
        super.unregisterForNotifications()
    }
}

// MARK: - Register cells
// MARK:

extension HomeListViewController {
    
    // Register vehicle cell
    func registerCellsForTableView() {
        let nibName = UINib(nibName: "PropertyListTableViewCell", bundle:nil)
        self.tblTable.register(nibName, forCellReuseIdentifier: "PropertyListTableViewCell")
    }
}

// MARK: - UITableViewDelegate
// MARK:

extension HomeListViewController: UITableViewDelegate {
    
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
        router?.routeToDetailsViewController(params: ["model": propertyList[indexPath.row]])
    }
}

// MARK: - UITableViewDatasource
// MARK:

extension HomeListViewController: UITableViewDataSource {
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.propertyList.count
    }
    
    // Cell For Row at IndexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create cell
        let cell = PropertyListTableViewCell.initCell(
            tableView,
            itemAtIndexPath: indexPath,
            params: ["model": self.propertyList[indexPath.row],
                     "isFavorite": self.favoriteIdList.contains(self.propertyList[indexPath.row].advertisementId ?? -666)],
            context: self)
        
        // Add delegate
        cell.delegate = self
        
        // Return cell
        return cell
    }
}

// MARK: Implement Property list delegate with update favorite action

extension HomeListViewController: PropertyListTableViewCellDelegate {
    
    // Update favorite
    func updateFavorite(model: PropertyModel) {
        do {
            try CoreDataManager.update(favorite: model)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

