//
//  InfoFeedbackCell.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 06.03.24.
//

import UIKit

final class InfoFeedbackCell: UITableViewCell {
    
    static let reuseIdentifier = "InfoFeedbackCell"
    
    private let backgroundContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .mainPrimary
        return view
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.tintColor = .mainSecondary
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let characterTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension InfoFeedbackCell {
    private func setup() {
        setupSubViews()
        setupConstraints()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setupSubViews() {
        contentView.addSubview(backgroundContainer)
        backgroundContainer.addSubview(mainStackView)
        mainStackView.addArrangedSubview(iconImageView)
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
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: ViewModel & Configuration
extension InfoFeedbackCell {
    struct ViewModel {
        let title: String
        let image: UIImage
    }
    
    func configure(model: ViewModel) {
        iconImageView.image = model.image
        characterTitle.text = model.title
    }
}

