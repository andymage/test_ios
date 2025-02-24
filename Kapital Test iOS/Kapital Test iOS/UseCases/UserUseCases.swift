//
//  UserUseCases.swift
//  Kapital Test iOS
//
//  Created by Miguel Eduardo on 24/02/25.
//

import Foundation

protocol FetchUsersUseCaseProtocol {
    func execute() async throws -> [UserModel]
}

struct FetchUsersUseCase: FetchUsersUseCaseProtocol {
    func execute() async throws -> [UserModel] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([UserModel].self, from: data)
    }
}
