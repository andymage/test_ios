//
//  UserViewModel.swift
//  Kapital Test iOS
//
//  Created by Miguel Eduardo on 24/02/25.
//

import Foundation

@MainActor
class UsersViewModel: ObservableObject {
    @Published var users: [UserModel] = [] {
        didSet { onUsersUpdated?() }
    }

    @Published var favoriteUsers: [UserModel] = [] {
        didSet { onUsersUpdated?() }
    }

    var onUsersUpdated: (() -> Void)?

    private let fetchUsersUseCase: FetchUsersUseCaseProtocol
    private let favoritesKey = "favoriteUserIDs"

    init(fetchUsersUseCase: FetchUsersUseCaseProtocol = FetchUsersUseCase()) {
        self.fetchUsersUseCase = fetchUsersUseCase
        loadFavorites()
    }

    func fetchUsers() async {
        do {
            users = try await fetchUsersUseCase.execute()
            updateFavoriteUsers()
        } catch {
            print("Error fetching users: \(error)")
        }
    }

    func addToFavorites(user: UserModel) {
        var favoriteIDs = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
        if !favoriteIDs.contains(user.id) {
            favoriteIDs.append(user.id)
            UserDefaults.standard.setValue(favoriteIDs, forKey: favoritesKey)
            updateFavoriteUsers()
        }
    }

    func removeFromFavorites(user: UserModel) {
        var favoriteIDs = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
        favoriteIDs.removeAll { $0 == user.id }
        UserDefaults.standard.setValue(favoriteIDs, forKey: favoritesKey)
        updateFavoriteUsers()
    }

    private func loadFavorites() {
        updateFavoriteUsers()
    }

    private func updateFavoriteUsers() {
        let favoriteIDs = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
        favoriteUsers = users.filter { favoriteIDs.contains($0.id) }
    }

    func isFavorite(user: UserModel) -> Bool {
        let favoriteIDs = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
        return favoriteIDs.contains(user.id)
    }
}
