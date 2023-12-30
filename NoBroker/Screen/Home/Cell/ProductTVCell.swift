//
//  ProductTVCell.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import UIKit
import SDWebImage


class ProductTVCell: UITableViewCell {
    var title: UILabel!
    var thumbnail: UIImageView!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    
    private func createUI() {
        title = UILabel()
        title.font = .systemFont(ofSize: 16, weight: .semibold)
        title.numberOfLines = 2
        contentView.addSubview(title)
        
        thumbnail = UIImageView()
        thumbnail.layer.borderWidth = 0.6
        thumbnail.layer.borderColor = UIColor.gray.cgColor
        thumbnail.layer.cornerRadius = 4
        thumbnail.layer.masksToBounds = true
        thumbnail.contentMode = .scaleAspectFit
        contentView.addSubview(thumbnail)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        
        let heightAnchor =  thumbnail.heightAnchor.constraint(equalToConstant: 112)
        heightAnchor.priority = contentCompressionResistancePriority(for: .vertical)
        
        NSLayoutConstraint.activate([
            heightAnchor,
            thumbnail.widthAnchor.constraint(equalToConstant: 88),
            
            thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            thumbnail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
}



extension ProductTVCell: ListCell {
    
    func populate(data: ListCellData) {
        if let item = data as? Product {
            title.text = item.title
            thumbnail.sd_setImage(with: URL(string: item.thumbnail), placeholderImage: UIImage(systemName: "photo")) //.sd_setImage(with: )
        }
    }
    
}
