//
//  UserViewcontroller.swift.swift
//  Kapital Test iOS
//
//  Created by Miguel Eduardo on 24/02/25.
//

import UIKit

class UserViewController: UIViewController {

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Users", "Favorites"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserCellUikit.self, forCellReuseIdentifier: UserCellUikit.identifier)
        return tableView
    }()

    private let viewModel = UsersViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        Task { await viewModel.fetchUsers() }
    }

    private func setupUI() {
        title = "Kapital Users"
        view.backgroundColor = .white

        view.addSubview(segmentedControl)
        view.addSubview(tableView)

        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc private func segmentChanged() {
        tableView.reloadData()
    }

    private func setupBindings() {
        viewModel.onUsersUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        segmentedControl.selectedSegmentIndex == 0 ? viewModel.users.count : viewModel.favoriteUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCellUikit.identifier, for: indexPath) as? UserCellUikit else {
            return UITableViewCell()
        }
        
        let user = segmentedControl.selectedSegmentIndex == 0 ? viewModel.users[indexPath.row] : viewModel.favoriteUsers[indexPath.row]
        let isFavorite = viewModel.isFavorite(user: user)
        
        cell.configure(with: user, isFavorite: isFavorite) { [weak self] in
            if isFavorite {
                self?.viewModel.removeFromFavorites(user: user)
            } else {
                self?.viewModel.addToFavorites(user: user)
            }
        }
        
        return cell
    }
}
