//
//  UserCell.swift
//  Kapital Test iOS
//
//  Created by Miguel Eduardo on 24/02/25.
//

import SwiftUI

struct UserCell: View {
    let user: UserModel
    let isFavorite: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                NamesCell(title: "User Name:", subtitle: user.name)
                NamesCell(title: "Company:", subtitle: user.company.name)
                NamesCell(title: "City:", subtitle: user.address.city)
                NamesCell(title: "Website:", subtitle: user.website)
            }
            
            Spacer()
            
            Button(action: action) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
                    .font(.system(size: 30))
                    .animation(.easeInOut, value: isFavorite)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: .infinity)
    }
}
