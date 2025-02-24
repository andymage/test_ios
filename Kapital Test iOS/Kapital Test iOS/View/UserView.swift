//
//  ContentView.swift
//  Kapital Test iOS
//
//  Created by Miguel Eduardo on 24/02/25.
//

import SwiftUI

struct UserView: View {
    @StateObject private var viewModel = UsersViewModel()
    @State private var selectedSegment = 0
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                List {
                    if selectedSegment == 0 {
                        if viewModel.users.isEmpty {
                            Text("No users yet")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        } else {
                            ForEach(viewModel.users) { user in
                                UserCell(user: user, isFavorite: viewModel.isFavorite(user: user)) {
                                    viewModel.addToFavorites(user: user)
                                }
                            }
                        }
                    } else {
                        if viewModel.favoriteUsers.isEmpty {
                            Text("No favorites yet")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        } else {
                            ForEach(viewModel.favoriteUsers) { user in
                                UserCell(user: user, isFavorite: true) {
                                    viewModel.removeFromFavorites(user: user)
                                }
                            }
                        }
                    }
                }
                .listStyle(.grouped)
                .padding(.top, 20)
                
                Color.white.frame(height: 65)
                
                Picker("Select", selection: $selectedSegment) {
                    Text("Users").tag(0)
                    Text("Favorites").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            .navigationBarTitle("Kapital Users", displayMode: .inline)
            .padding(.horizontal, 8)
        }
        .task {
            await viewModel.fetchUsers()
        }
    }
}

#Preview {
    UserView()
}
