//
//  NamesCell.swift
//  Kapital Test iOS
//
//  Created by Miguel Eduardo on 24/02/25.
//

import SwiftUI

struct NamesCell: View {
    var title: String
    var subtitle: String
    var body: some View {
        HStack {
            Text(title)
                .font(Font.headline.weight(.bold))
            
            Text(subtitle)
                .font(Font.headline.weight(.regular))
                .multilineTextAlignment(.leading)
            
        }
    }
}
