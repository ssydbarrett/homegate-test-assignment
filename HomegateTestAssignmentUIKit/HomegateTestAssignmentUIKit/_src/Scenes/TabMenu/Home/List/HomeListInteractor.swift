//
//  HomeListInteractor.swift
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

protocol HomeListBusinessLogic
{
  
    // Call API
    func handlePropertyList(request: HomeList.PropertyList.Request)
}

protocol HomeListDataStore
{
  //var name: String { get set }
}

class HomeListInteractor: HomeListBusinessLogic, HomeListDataStore
{
  var presenter: HomeListPresentationLogic?
  var worker: HomeListWorker?
  //var name: String = ""
  
  // MARK: Call API
  
    func handlePropertyList(request: HomeList.PropertyList.Request) {
        
        // Get all properties
        PropertiesNetworkManager.getProperties { result, status, error in
            
            // Call presenter with result
            self.presenter?.presentPropertyList(response: HomeList.PropertyList.Response(result: result, status: status, networkError: error))
        }
    }
}
