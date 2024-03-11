//
//  SeriesCollectionViewCell.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 06.03.24.
//

import UIKit

final class SeriesCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SeriesCollectionViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let seriesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupSubViews()
        setupCosntraints()
        setupUI()
    }
    
    private func setupSubViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(seriesLabel)
    }
    
    private func setupCosntraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            seriesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            seriesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            seriesLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            seriesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor
        seriesLabel.layer.addShadowEffect()
        seriesLabel.layer.addCornerRadius(radius: 12)
        seriesLabel.textColor = .white
        backgroundColor = .mainPrimaryBackground
    }
    
    func configure(string: String, isSelected: Bool) {
        seriesLabel.text = string
        containerView.backgroundColor = isSelected
        ? .mainPrimary
        : .mainSecondary.withAlphaComponent(0.7)
        seriesLabel.textColor = isSelected ? .white : .black
    }
}
