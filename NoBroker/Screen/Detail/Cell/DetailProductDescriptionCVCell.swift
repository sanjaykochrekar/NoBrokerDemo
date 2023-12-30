//
//  DetailProductDescriptionCVCell.swift
//  NoBroker
//
//  Created by Sanju on 30/12/23.
//


import UIKit



class DetailProductDescriptionCVCell: UICollectionViewCell {
    
    var productDescription: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    
    private func createUI() {
        productDescription = UILabel()
        productDescription.text = "--"
        productDescription.numberOfLines = 0
        addSubview(productDescription)
        
        productDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productDescription.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            productDescription.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            productDescription.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            productDescription.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
}


extension DetailProductDescriptionCVCell: ListCell {
    func populate(data: ListCellData) {
        guard let item = data as? DetailDescription else { return }
        productDescription.text = item.description
    }
}


