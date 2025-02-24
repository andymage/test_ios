//
//  Kapital_Test_iOSApp.swift
//  Kapital Test iOS
//
//  Created by Miguel Eduardo on 24/02/25.
//

import SwiftUI

@main
struct Kapital_Test_iOSApp: App {
    @StateObject private var viewModel = UsersViewModel()
    var body: some Scene {
        WindowGroup {
            UserViewControllerRepresentable(viewModel: viewModel)
                .ignoresSafeArea()
                .onAppear {
                    Task {
                        await viewModel.fetchUsers()
                    }
                }
        }
    }
}
