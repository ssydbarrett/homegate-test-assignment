//
//  HomeDetailsViewController.swift
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

protocol HomeDetailsDisplayLogic: AnyObject
{
    func displaySomething(viewModel: HomeDetails.Something.ViewModel)
}

class HomeDetailsViewController: BaseViewController, HomeDetailsDisplayLogic
{
    var interactor: HomeDetailsBusinessLogic?
    var router: (NSObjectProtocol & HomeDetailsRoutingLogic & HomeDetailsDataPassing)?
    
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
        let interactor = HomeDetailsInteractor()
        let presenter = HomeDetailsPresenter()
        let router = HomeDetailsRouter()
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
    
    // Header
    
    @IBOutlet weak var btnFavorite: UIButton!
    
    // Container
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewScrollView: UIScrollView!
    
    // Top view
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgPlaceholder: UIImageView!
    @IBOutlet weak var collectionViewPictures: UICollectionView!
    @IBOutlet weak var viewPictureNumber: UIView!
    @IBOutlet weak var lblPictureNumber: UILabel!
    
    // Price / Street
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgLocationMarker: UIImageView!
    @IBOutlet weak var lblStreet: UILabel!
    
    // Main informations
    @IBOutlet weak var lblMainInformations: UILabel!
    @IBOutlet weak var lblNoOfRoom: UILabel!
    @IBOutlet weak var lblNoOfRoomValue: UILabel!
    @IBOutlet weak var lblFloor: UILabel!
    @IBOutlet weak var lblFloorValue: UILabel!
    @IBOutlet weak var lblLivingSpace: UILabel!
    @IBOutlet weak var lblLivingSpaceValue: UILabel!
    
    // External links
    @IBOutlet weak var imgExternalLinksDivider: UIImageView!
    @IBOutlet weak var viewExternalLinks: UIView!
    @IBOutlet weak var constraintExternalLinksTop: NSLayoutConstraint!
    @IBOutlet weak var constraintExternalLinksHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintExternalLinksBottom: NSLayoutConstraint!
    
    // Description
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDescriptionTitle: UILabel!
    @IBOutlet weak var lblDescriptionText: UILabel!
    
    // MARK: Properties
    
    var model: PropertyModel!
    var isFavorite: Bool!
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set params
        setParams()
        
        // Configure view
        configureView()
    }
    
    // Set params
    func setParams() {
        self.model = params["model"] as? PropertyModel ?? PropertyModel()
        self.isFavorite = params["isFavorite"] as? Bool ?? false
    }
    
    // MARK: Configuration
    
    // Configure view
    func configureView() {
        
        // Configure favorite button
        btnFavorite.backgroundColor = UIColor.clear
        var templateImage = btnFavorite.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
        btnFavorite.setImage(templateImage, for: .normal)
        templateImage = btnFavorite.image(for: .selected)?.withRenderingMode(.alwaysTemplate)
        btnFavorite.setImage(templateImage, for: .selected)
        btnFavorite.tintColor = Color.iconRed
        
        // Set favorite button selected
        btnFavorite.isSelected = self.isFavorite
        
        // Set if favorite
        btnFavorite.isSelected = self.isFavorite
        
        // Configure top view
        configureTopView()
        
        // Configure Price label
        lblPrice.text = String(format: "%@%@%@",
                               String(model.price ?? 0),
                               model.currency == nil || model.currency == "" ? "" : " ",
                               model.currency ?? "")
        
        // Configure street icon and label
        templateImage = imgLocationMarker.image?.withRenderingMode(.alwaysTemplate)
        imgLocationMarker.image = templateImage
        imgLocationMarker.tintColor = Color.foregroundPurple
        let street = model.street ?? ""
        let city = String(format: "%@%@%@",
                          model.zip ?? "",
                          model.zip == nil || model.zip == "" || model.city == nil || model.city == "" ? "" : " ",
                          model.city ?? "")
        lblStreet.text = String(format: "%@%@%@",
                                street,
                                street == "" || city == "" ? "" : ", ",
                                city)
        lblStreet.textColor = Color.foregroundPurple
        
        // Configure main information view
        
        // Handle number of rooms
        let noOfRoom = String(format: "%0.1f", self.model.numberRooms ?? 0.0) == "0.0" ? "n/a" : String(format: "%0.1f", self.model.numberRooms ?? 0.0)
        lblNoOfRoomValue.text = noOfRoom
        
        // Handle floors
        let floor = String(self.model.floor ?? 0) == "0" ? (self.model.floorLabel ?? "" == "" ? "n/a" : self.model.floorLabel ?? "") : String(self.model.floor ?? 0)
        lblFloorValue.text = floor
        
        // Handle living space
        let livingSpace = ((self.model.surfaceLiving ?? 0) == 0) ? "n/a" : String(format: "%d m2", self.model.surfaceLiving ?? 0)
        if livingSpace != "n/a" {
            
            // If living space not empty - add superscript as attributed string
            let font:UIFont? = UIFont(name: "Helvetica", size:17)
            let fontSuper:UIFont? = UIFont(name: "Helvetica", size:10)
            let livingSpaceAttString:NSMutableAttributedString = NSMutableAttributedString(string: livingSpace, attributes: [.font: font!, .foregroundColor: UIColor.label])
            livingSpaceAttString.setAttributes([.font:fontSuper!, .baselineOffset:livingSpace.count], range: NSRange(location:livingSpace.count - 1, length:1))
            lblLivingSpaceValue.attributedText = livingSpaceAttString
        } else {
            
            // Set empty living space value
            lblLivingSpaceValue.text = livingSpace
        }
        
        // Configure external links if existing
        configureExternalLinks()
        
        // Configure title and description
        lblDescriptionTitle.text = model.title ?? "Title"
        lblDescriptionText.text = model.description ?? "description ..."
    }
    
    // Configure top view
    func configureTopView() {
        
        // Configure collection view
        collectionViewPictures.backgroundColor = .separator
        
        // Configure slider collection view
        collectionViewPictures.delegate = self
        collectionViewPictures.dataSource = self
        
        // Register cells for slider collection view
        self.registerCellsForCollectionView()
        
        // Configure placeholder and picture numbers
        if self.model.getClearedPictures().count != 0 {
            
            // Hide placeholder
            self.imgPlaceholder.alpha = 0.0
            
            // Update number of images view and label
            self.viewPictureNumber.layer.cornerRadius = 4.0
            self.viewPictureNumber.layer.masksToBounds = true
            self.lblPictureNumber.text = "\(1)" + " / " + "\(self.model.getClearedPictures().count)"
            
        // No pictures
        } else {
            
            // Configure placeholder
            imgPlaceholder.image = UIImage(named: "ic-image-placeholder")?.withRenderingMode(.alwaysTemplate)
            imgPlaceholder.contentMode = .center
            imgPlaceholder.backgroundColor = .separator
            imgPlaceholder.tintColor = .label
            
            // Hide collection view and number of images view
            self.collectionViewPictures.alpha = 0.0
            self.viewPictureNumber.alpha = 0.0
        }
    }
    
    // Configure external links view
    func configureExternalLinks() {
        
        // Handle empty external links
        if model.externalUrls?.count ?? 0 == 0 {
            
            // Hide external links view
            self.viewExternalLinks.alpha = 0.0
            
            // Handle constraints
            self.constraintExternalLinksTop.constant = 0.0
            self.constraintExternalLinksHeight.constant = 0.0
            self.constraintExternalLinksBottom.constant = 0.0
            self.view.layoutIfNeeded()
        }
        
        // Draw external links view
        else {
            
            // Set initial view height
            var externalLinksViewHeight: CGFloat = 0.0
            var externalLinksButtonTag: Int = 0
            
            // Iterate and configure every external link
            for externalLink in self.model.externalUrls ?? [ExternalUrlModel]() {
                
                // Create container view
                let externalLinkView = UIView(frame: CGRect(x: 0.0, y: externalLinksViewHeight, width: Utils.getScreenSize().width - 32.0, height: 44.0))
                externalLinkView.backgroundColor = .clear
                
                // Set type
                let externalLinksType: ExternalUrl = ExternalUrl(rawValue: externalLink.type ?? "DOCUMENT") ?? .document
                
                // Create icon
                let externalUrlY: CGFloat = (44.0 - 32.0) / 2.0
                let externalUrlIcon = UIImageView(frame: CGRect(x: 0.0, y: externalUrlY, width: 32.0, height: 32.0))
                var externalUrlIconImage = ""
                switch externalLinksType {
                case .document:
                    externalUrlIconImage = "ic-attachment"
                case .tour:
                    externalUrlIconImage = "ic-360"
                }
                
                // Set icon image
                externalUrlIcon.image = UIImage(named: externalUrlIconImage)?.withRenderingMode(.alwaysTemplate)
                externalUrlIcon.contentMode = .scaleAspectFit
                externalUrlIcon.backgroundColor = .clear
                externalUrlIcon.tintColor = .label
                externalUrlIcon.isUserInteractionEnabled = false
                
                // Add icon to view
                externalLinkView.addSubview(externalUrlIcon)
                
                // Create title label
                let externalUrlLabelX = externalUrlIcon.frame.size.width + 12.0
                let externalUrlLabel = UILabel(frame: CGRect(x: externalUrlLabelX, y: externalUrlY, width: self.viewExternalLinks.frame.size.width - externalUrlLabelX, height: 32.0))
                externalUrlLabel.font = UIFont(name: "Helvetica", size: 15.0)
                externalUrlLabel.textColor = .label
                externalUrlLabel.numberOfLines = 2
                externalUrlLabel.minimumScaleFactor = 0.5
                externalUrlLabel.isUserInteractionEnabled = false
                
                // Set title label text
                if externalLink.label ?? "" != "" {
                    externalUrlLabel.text = externalLink.label ?? ""
                    
                // Set label placeholder text based on type
                } else {
                    switch externalLinksType {
                    case .document:
                        externalUrlLabel.text = "See attachment..."
                    case .tour:
                        externalUrlLabel.text = "Explore virtual tour..."
                    }
                }
                
                // Add label to view
                externalLinkView.addSubview(externalUrlLabel)
                
                // Create touch button
                let externalUrlButton = UIButton(type: .custom)
                externalUrlButton.frame = CGRect(x: 0.0, y: 0.0, width: self.viewExternalLinks.frame.size.width, height: 44.0)
                externalUrlButton.setTitle("", for: .normal)
                externalUrlButton.setImage(nil, for: .normal)
                externalUrlButton.isUserInteractionEnabled = true
                externalUrlButton.tag = externalLinksButtonTag

                // Set button target and add to view
                externalUrlButton.addTarget(self, action: #selector(openExternalLink(_:)), for: .touchUpInside)
                externalLinkView.addSubview(externalUrlButton)
                externalLinkView.bringSubviewToFront(externalUrlButton)
                
                // Add newly created and populated view to outlet
                self.viewExternalLinks.addSubview(externalLinkView)
                
                // Calculate new height and tag
                externalLinksViewHeight += 44.0
                externalLinksButtonTag += 1
            }
            
            // Update constraints
            self.constraintExternalLinksTop.constant = 10.0
            self.constraintExternalLinksHeight.constant = externalLinksViewHeight
            self.constraintExternalLinksBottom.constant = 10.0
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: Button actions
    
    @IBAction func updateFavorites(_ sender: UIButton) {
        
        // Update favorite button
        self.isFavorite.toggle()
        self.btnFavorite.isSelected = self.isFavorite
        
        // Update favorite in core data
        do {
            try CoreDataManager.update(favorite: model)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @objc func openExternalLink(_ sender: UIButton) {
        
        // Open url based on sender tag
        router?.routeToExternalLink(params: ["url": self.model.externalUrls?[sender.tag].url ?? ""])
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = HomeDetails.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: HomeDetails.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}

// MARK: - Configuration
// MARK:

extension HomeDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Register collection view cells
    func registerCellsForCollectionView() {
        let nibName = UINib(nibName: "PictureSliderCollectionViewCell", bundle:nil)
        self.collectionViewPictures.register(nibName, forCellWithReuseIdentifier: "PictureSliderCollectionViewCell")
    }

    // Cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Set Cell Size with aspect ratio 16:10
        return CGSize(width: Utils.getScreenSize().width, height: Utils.getScreenSize().width * 10.0 / 16.0)
    }
    
    // Item selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Do nothin'
    }
    
    // Number of sections in collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Number of items in section in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Number of sections
        return self.model.pictures?.count ?? 0
    }
    
    // Cell for item at index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get slider image cell
        return PictureSliderCollectionViewCell.initItem(collectionView, itemAtIndexPath: indexPath, params: ["url": self.model.getClearedPictures()[indexPath.row] ?? ""], context: self)
    }
    
    // Handle colllection view scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Update picture number based on collection view offset
        if scrollView == self.collectionViewPictures {
            
            // Prepare picture numbers params
            let scrollingOffset = scrollView.contentOffset.x
            let imageWidth = Utils.getScreenSize().width
            var currentImage = 1
            let noOfImages = self.model.pictures?.count ?? 0
            
            // Calculate current image number
            currentImage = Int((scrollingOffset + imageWidth / 2.0) / imageWidth) + 1
            print("current image: " + "\(currentImage)")
            
            // Update number of images label
            self.lblPictureNumber.text = "\(currentImage)" + " / " + "\(noOfImages)"
        }
    }
}


