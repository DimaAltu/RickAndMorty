//
//  CharacterDetailsView.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 07.03.24.
//

import UIKit

final class CharacterDetailsInfoView: UIView {
    
    private let horizontlStackView: UIStackView =  {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.spacing = 16
        return stack
    }()
    
    private let textsVerticalStackview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 4
        return stack
    }()
    
    private let infoImageContrainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let infoImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 10)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    public convenience init(with model: ViewModel) {
        self.init()
        configure(with: model)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupSubViews()
        setupConstraints()
        setupUI()
    }
    
    private func setupSubViews() {
        addSubview(horizontlStackView)
        horizontlStackView.addArrangedSubview(infoImageContrainer)
        infoImageContrainer.addSubview(infoImage)
        horizontlStackView.addArrangedSubview(textsVerticalStackview)
        textsVerticalStackview.addArrangedSubview(titleLabel)
        textsVerticalStackview.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            infoImage.leadingAnchor.constraint(equalTo: infoImageContrainer.leadingAnchor, constant: 8),
            infoImage.trailingAnchor.constraint(equalTo: infoImageContrainer.trailingAnchor, constant: -8),
            infoImage.topAnchor.constraint(equalTo: infoImageContrainer.topAnchor, constant: 8),
            infoImage.bottomAnchor.constraint(equalTo: infoImageContrainer.bottomAnchor, constant: -8),
            horizontlStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            horizontlStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            horizontlStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            horizontlStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            infoImage.heightAnchor.constraint(equalToConstant: 24),
            infoImage.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupUI() {
        layer.cornerRadius = 8
        infoImageContrainer.layer.addShadowEffect()
        infoImageContrainer.layer.addCornerRadius(radius: 12)
    }
    
    func configure(with model: ViewModel) {
        infoImage.image = model.image
        infoImage.tintColor = model.imageColor
        infoImageContrainer.backgroundColor = .gray.withAlphaComponent(0.3)
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        backgroundColor = .mainPrimary
    }
}

extension CharacterDetailsInfoView {
    struct ViewModel {
        let image: UIImage
        let imageColor: UIColor
        let title: String
        let description: String
    }
}
