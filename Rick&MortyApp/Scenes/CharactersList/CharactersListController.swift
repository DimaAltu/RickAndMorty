//
//  CharactersListController.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 04.03.24.
//

import UIKit

final class CharactersListController: UIViewController {
    
    var presenter: CharactersListPresenter!
    
    //MARK: Views
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.startAnimating()
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseIdentifier)
        tableView.register(InfoFeedbackCell.self, forCellReuseIdentifier: InfoFeedbackCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController()
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = presenter.dataProvider.searchPlaceholder
        search.searchBar.setValue(presenter.dataProvider.searchCancelTitle, forKey: "cancelButtonText")

        return search
    }()
    
    private lazy var filterBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(title: presenter.dataProvider.filterButtonTitle)
        return item
    }()
    
    //MARK: Init
    
    init(with configurator: CharactersListConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(controller: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = filterBarButton
    }
    
    //MARK: Private methods
    
    private func setup() {
        setupSubViews()
        setupConstraints()
        setupUI()
    }
    
    private func setupSubViews() {
        view.addSubview(tableView)
        view.addSubview(loader)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupUI() {
        title = presenter.dataProvider.navTitle
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        tableView.backgroundColor = .mainPrimaryBackground
        reloadFilterData()
    }
    
    private func getMenuModel() -> UIMenu {
        let genderMenu = UIMenu(
            title: presenter.dataProvider.genderFilerModel.title,
            image: UIImage(named: presenter.dataProvider.genderFilerModel.image),
            children: presenter.dataProvider.genderFilerModel.filterType.map { type in
                UIAction(
                    title: type.element.rawValue,
                    image: type.isSelected ? UIImage(systemName: "checkmark.circle.fill") : nil
                ) { [weak self] _ in
                    self?.presenter.didSelectedGenderFilter(type: type.element)
                }
            }
        )
        let statusMenu = UIMenu(
            title: presenter.dataProvider.statusFilterModel.title,
            image: UIImage(named: presenter.dataProvider.statusFilterModel.image),
            children: presenter.dataProvider.statusFilterModel.filterType.map { type in
                UIAction(
                    title: type.element.rawValue,
                    image: type.isSelected ? UIImage(systemName: "checkmark.circle.fill") : nil)
                { [weak self] _ in
                    self?.presenter.didSelectedStatusFilter(type: type.element)
                }
            }
        )
        return UIMenu(title: presenter.dataProvider.filterButtonTitle,
                      children: [genderMenu, statusMenu])
    }
    
}

//MARK: CharactersListView Confirmation
extension CharactersListController: CharactersListView {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func reloadFilterData() {
        filterBarButton.menu = getMenuModel()
    }
    
    func startAnimating() {
        loader.startAnimating()
    }
    
    func stopAnimating() {
        loader.stopAnimating()
    }
}

//MARK: UISearchResultsUpdating
extension CharactersListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.searchedText = searchController.searchBar.text
    }
}

//MARK: UITableViewDataSource & UITableViewDelegate
extension CharactersListController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return switch presenter.viewState {
        case .loading: 0
        case .loaded: presenter.dataProvider.characterItemsDataProvider.count
        case .empty: 1
        case .error(_): 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.viewState {
        case .loading:
            return UITableViewCell() //TODO: Shimmer
        case .loaded:
            if let characterCell = tableView.dequeueReusableCell(
                withIdentifier: CharacterCell.reuseIdentifier,
                for: indexPath) as? CharacterCell {
                let cellData = presenter.dataProvider.characterItemsDataProvider[indexPath.row]
                characterCell.configure(
                    model: CharacterCell.ViewModel(
                        imageUrl: cellData.imageUrl,
                        title: cellData.title,
                        backgroundColor: .mainPrimaryBackground))
                return characterCell
            }
        case .empty:
            return getInfoCell(
                title: presenter.dataProvider.emptyFilterViewTitle,
                indexPath: indexPath)
        case .error(let string):
            return getInfoCell(
                title: string,
                indexPath: indexPath)
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.dataProvider.characterItemsDataProvider.count - 1 {
            presenter.getCharacters()
        }
    }
    
    private func getInfoCell(title: String, indexPath: IndexPath) -> UITableViewCell {
        if let infoCell = tableView.dequeueReusableCell(withIdentifier: InfoFeedbackCell.reuseIdentifier, for: indexPath) as? InfoFeedbackCell {
            infoCell.configure(model: InfoFeedbackCell.ViewModel(title: title, image: UIImage(systemName: "clear")!))
            return infoCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTappedCharacter(at: indexPath.row)
    }
}


