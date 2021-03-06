//
//  TabMenuContainerModels.swift
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

enum TabMenuContainer
{
    // MARK: -
    // MARK: Use cases
    // MARK: -
    
    // Init controllers model
    enum InitControllers
    {
        struct Request
        {
        }
        struct Response
        {
        }
        struct ViewModel
        {
        }
    }
    
    // Tab Button
    enum TabButton
    {
        struct Request
        {
            var sender: UIButton
        }
        struct Response
        {
            var sender: UIButton
        }
        struct ViewModel
        {
            var sender: UIButton
        }
    }
}
