//
//  UserCellUikit.swift
//  Kapital Test iOS
//
//  Created by Miguel Eduardo on 24/02/25.
//

import UIKit

class UserCellUikit: UITableViewCell {
    static let identifier = "UserCell"

    private let nameLabel = NamesCellUikit(title: "User Name:")
    private let companyLabel = NamesCellUikit(title: "Company:")
    private let cityLabel = NamesCellUikit(title: "City:")
    private let websiteLabel = NamesCellUikit(title: "Website:")

    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        return button
    }()

    private var favoriteAction: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [nameLabel, companyLabel, cityLabel, websiteLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)
        contentView.addSubview(favoriteButton)

        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with user: UserModel, isFavorite: Bool, favoriteAction: @escaping () -> Void) {
        nameLabel.setSubtitle(user.name)
        companyLabel.setSubtitle(user.company.name)
        cityLabel.setSubtitle(user.address.city)
        websiteLabel.setSubtitle(user.website)

        let imageName = isFavorite ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = isFavorite ? .systemYellow : .gray
        self.favoriteAction = favoriteAction
    }

    @objc private func favoriteTapped() {
        favoriteAction?()
    }
}
