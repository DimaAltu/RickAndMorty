//
//  CharacterCell.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 04.03.24.
//

import UIKit

final class CharacterCell: UITableViewCell {
    
    static let reuseIdentifier = "CharacterCell"
    
    private let backgroundContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .mainPrimary
        return view
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    private let characterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let characterTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private var imageUrl: String = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension CharacterCell {
    private func setup() {
        setupSubViews()
        setupConstraints()
        selectionStyle = .none
        backgroundColor = .mainPrimaryBackground
    }
    
    private func setupSubViews() {
        contentView.addSubview(backgroundContainer)
        backgroundContainer.addSubview(mainStackView)
        mainStackView.addArrangedSubview(characterImage)
        mainStackView.addArrangedSubview(characterTitle)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            backgroundContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            backgroundContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            mainStackView.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor, constant: -16),
            characterImage.heightAnchor.constraint(equalToConstant: 50),
            characterImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: ViewModel & Configuration
extension CharacterCell {
    struct ViewModel {
        let imageUrl: String
        let title: String
        let backgroundColor: UIColor
    }
    
    func configure(model: ViewModel) {
        characterTitle.text = model.title
        imageUrl = model.imageUrl
        contentView.backgroundColor = model.backgroundColor
        downloadImage(from: .init(string: model.imageUrl)) { [weak self] image in
            if self?.imageUrl == model.imageUrl {
                self?.characterImage.image = image
            }
        }
    }
}
