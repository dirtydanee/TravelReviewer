//
//  ProfilePictureViewModel.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 13.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import Combine
import UIKit

final class ProfilePictureViewModel: ObservableObject {

    @Published var image: UIImage = UIImage()

    private let networkingClient: NetworkingClient

    let photoURL: URL?
    let initials: String
    let reviewFooterText: String

    init(networkingClient: NetworkingClient, author: Author) {
        self.networkingClient = networkingClient
        self.photoURL = author.photo
        self.initials = String(author.fullName.prefix(1)).uppercased()
        switch author.country {
        case .none:
            self.reviewFooterText = author.fullName
        case .some(let value):
            self.reviewFooterText = author.fullName + " - " + value
        }
    }
    
    func fetchPhoto() {
        guard let photoURL = photoURL else {
            return
        }

        let request = ProfileImageNetworkRequest(url: photoURL)
        networkingClient.execute(request: request) { result in
            switch result {
            case .failure(let error):
                print("Failed to fetch photo with error: \(error)")
            case .success(let data):
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
    }
}
