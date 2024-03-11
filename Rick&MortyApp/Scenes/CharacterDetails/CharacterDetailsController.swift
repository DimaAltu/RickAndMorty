//
//  CharacterDetailsController.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 07.03.24.
//

import UIKit

final class CharacterDetailsController: UIViewController {
    
    var presenter: CharacterDetailsPresenter!
    
    //MARK: Views
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentSize = view.bounds.size
        scroll.isDirectionalLockEnabled = true
        return scroll
    }()
    
    private let scrollViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let collectionViewStacks: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var episodesCollectionView: UICollectionView = {
        let collectionView = createCollectionView()
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            SeriesCollectionViewCell.self,
            forCellWithReuseIdentifier: SeriesCollectionViewCell.reuseIdentifier
        )
        return collectionView
    }()
    
    private lazy var charactersCollectionView: UICollectionView = {
        let collectionView = createCollectionView()
        collectionView.isHidden = true
        collectionView.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier
        )
        return collectionView
    }()
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }
    
    //MARK: Init
    init(with configurator: CharacterDetailsConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(controller: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecytcle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        episodesCollectionView.reloadData()
    }
    
    //MARK: Private methods
    private func setup() {
        setupSubViews()
        setupConstraints()
        setupUI()
        configureViews()
        view.layoutSubviews()
    }
    
    private func setupSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addSubview(imageView)
        scrollViewContainer.addSubview(titleLabel)
        scrollViewContainer.addSubview(infoStackView)
        scrollViewContainer.addSubview(collectionViewStacks)
        collectionViewStacks.addArrangedSubview(episodesCollectionView)
        collectionViewStacks.addArrangedSubview(charactersCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: scrollViewContainer.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor, constant: 16),
            
            titleLabel.centerXAnchor.constraint(equalTo: scrollViewContainer.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            
            infoStackView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16),
            infoStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            
            collectionViewStacks.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 16),
            collectionViewStacks.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            collectionViewStacks.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            collectionViewStacks.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            episodesCollectionView.heightAnchor.constraint(equalToConstant: 50),
            charactersCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupUI() {
        view.backgroundColor = .mainPrimaryBackground
    }
    
    private func configureViews() {
        title = presenter.dataProvider.navigationTitle
        titleLabel.text = presenter.dataProvider.infoTitle
        downloadImage(from: URL(string: presenter.dataProvider.imageUrl)) { [weak self] image in
            self?.imageView.image = image
        }
        imageView.layer.addCornerRadius(radius: 12)
        configureInfoView()
    }
    
    private func configureInfoView() {
        presenter.dataProvider.infoItems
            .map { createSingleInfoView(dataProvider: $0) }
            .forEach { view in infoStackView.addArrangedSubview(view) }
    }
    
    private func getRandomColor() -> UIColor {
        let colors: [UIColor] = [.blue, .green, .systemPink, .orange, .purple, .yellow]
        return colors.map { $0.withAlphaComponent(0.8) }.randomElement() ?? .black
    }
    
    private func createSingleInfoView(dataProvider: CharacterDetailsInfoDataProvider) -> CharacterDetailsInfoView {
        let model = CharacterDetailsInfoView.ViewModel(
            image: UIImage(systemName: dataProvider.systemImage) ?? .defaultPlaceholder,
            imageColor: .mainSecondary,
            title: dataProvider.title,
            description: dataProvider.description)
        return CharacterDetailsInfoView(with: model)
    }
}

//MARK: CharacterDetailsView Confirmation
extension CharacterDetailsController: CharacterDetailsView {
    func reloadEpisodesList() {
        episodesCollectionView.reloadData()
    }
    
    func showCharactersList() {
        charactersCollectionView.isHidden = false
    }
    
    func reloadCharactersList() {
        charactersCollectionView.reloadData()
    }
}

//MARK: UICollectionView DataSource
extension CharacterDetailsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == episodesCollectionView {
            return presenter.dataProvider.episodesListItems.count
        } else {
            return presenter.dataProvider.episodeCharacters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == episodesCollectionView {
            if let serieCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SeriesCollectionViewCell.reuseIdentifier, for: indexPath
            ) as? SeriesCollectionViewCell {
                let currentItem = presenter.dataProvider.episodesListItems[indexPath.row]
                serieCell.configure(string: currentItem.title, isSelected: currentItem.isSelected)
                return serieCell
            }
            return UICollectionViewCell()
        } else {
            if let characterCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath
            ) as? CharacterCollectionViewCell {
                let currentItem = presenter.dataProvider.episodeCharacters[indexPath.row]
                characterCell.imageURL = currentItem.imageUrl
                return characterCell
            }
            return UICollectionViewCell()
        }
    }
}

//MARK: UICollectionView Delegate
extension CharacterDetailsController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, 
                        didSelectItemAt indexPath: IndexPath) {
        if collectionView == episodesCollectionView {
            presenter.didSelectedEpisode(at: indexPath.row)
        } else {
            presenter.didSelectedCharacter(at: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == episodesCollectionView {
            return .init(width: 50, height: 50)
        } else {
            return .init(width: 100, height: 100)
        }
    }
}
