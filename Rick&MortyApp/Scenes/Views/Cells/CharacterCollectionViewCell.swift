//
//  CharacterCollectionViewCell.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 06.03.24.
//

import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CharacterCollectionViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let characterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    var imageURL: String? {
        didSet {
            if let url = imageURL {
                downloadImage(from: .init(string: url)) { [weak self] image in
                    if url == self?.imageURL {
                        self?.characterImage.image = image
                    }
                }
            }
            else { self.characterImage.image = nil }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        characterImage.layer.cornerRadius = containerView.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(containerView)
        containerView.addSubview(characterImage)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            characterImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            characterImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            characterImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            characterImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func configure(viewModel: ViewModel) {
        imageURL = viewModel.imageUrl
    }
}

extension CharacterCollectionViewCell {
    struct ViewModel {
        let imageUrl: String
    }
}
