//
//  CategoryCell.swift
//  Todoey
//
//  Created by Валентина Попова on 05.12.2024.
//

import UIKit

class CategoryCell: UITableViewCell {
    static let identifire = "CategoryCell"
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Food"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(categoryLabel: String) {
        DispatchQueue.main.async {
            self.categoryLabel.text = categoryLabel
        }
    }
    
    func setupUI() {
        contentView.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
        ])
    }
}
