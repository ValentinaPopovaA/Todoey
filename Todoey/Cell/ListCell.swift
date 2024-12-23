//
//  ListCell.swift
//  Todoey
//
//  Created by Валентина Попова on 05.12.2024.
//

import UIKit

class ListCell: UITableViewCell {
    
    static let identifire = "ToDoItemCell"
    
    var itemLabel: UILabel = {
        let label = UILabel()
        label.text = "Find Mike"
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
    
    public func configure(itemLabel: String) {
        DispatchQueue.main.async {
            self.itemLabel.text = itemLabel
        }
    }
    
    func setupUI() {
        contentView.addSubview(itemLabel)
        NSLayoutConstraint.activate([
            itemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
        ])
    }
}
