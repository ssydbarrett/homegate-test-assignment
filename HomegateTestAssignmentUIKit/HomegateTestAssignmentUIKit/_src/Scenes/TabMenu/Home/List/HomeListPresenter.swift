//
//  HomeListPresenter.swift
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

protocol HomeListPresentationLogic
{
  func presentSomething(response: HomeList.Something.Response)
}

class HomeListPresenter: HomeListPresentationLogic
{
  weak var viewController: HomeListDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: HomeList.Something.Response)
  {
    let viewModel = HomeList.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
