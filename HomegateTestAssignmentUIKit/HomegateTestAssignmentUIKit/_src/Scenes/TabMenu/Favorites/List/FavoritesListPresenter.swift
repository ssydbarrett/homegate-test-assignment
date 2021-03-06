//
//  FavoritesListPresenter.swift
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

protocol FavoritesListPresentationLogic
{
    // Handle API response
    func presentPropertyList(response: FavoritesList.PropertyList.Response)
}

class FavoritesListPresenter: FavoritesListPresentationLogic
{
    weak var viewController: FavoritesListDisplayLogic?
    
    // MARK: Core Data response
    
    func presentPropertyList(response: FavoritesList.PropertyList.Response) {
        if response.error != nil {
            
            // Call view controller display error
            viewController?.displayPropertyListCDError(error: FavoritesList.PropertyList.Error(error: response.error!))
        } else {
            
            // Call successful view controller
            viewController?.displayPropertyList(viewModel: FavoritesList.PropertyList.ViewModel(proppertyList: response.result ?? [PropertyModel]()))
        }
    }
}
