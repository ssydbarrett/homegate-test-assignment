//
//  HomeDetailsPresenter.swift
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

protocol HomeDetailsPresentationLogic
{
  func presentSomething(response: HomeDetails.Something.Response)
}

class HomeDetailsPresenter: HomeDetailsPresentationLogic
{
  weak var viewController: HomeDetailsDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: HomeDetails.Something.Response)
  {
    let viewModel = HomeDetails.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}