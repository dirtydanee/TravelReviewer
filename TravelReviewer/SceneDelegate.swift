//
//  SceneDelegate.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        let networkingClient = NetworkingClientImpl(jsonDecoder: .default, sessionConfiguration: .default)
        let viewModel = ReviewListsViewModel(networkingClient: networkingClient)
        let listView = ReviewsListView(reviewListsViewModel: viewModel)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: listView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

