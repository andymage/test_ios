//
//  UserViewControllerRepresentable.swift
//  Kapital Test iOS
//
//  Created by Miguel Eduardo on 24/02/25.
//

import UIKit
import SwiftUI
import Foundation

struct UserViewControllerRepresentable: UIViewControllerRepresentable {
    let viewModel: UsersViewModel

    func makeUIViewController(context: Context) -> UINavigationController {
        let userViewController = UserViewController()
        return UINavigationController(rootViewController: userViewController)
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}
