//
//  DetailProductTitleCVCell.swift
//  NoBroker
//
//  Created by Sanju on 30/12/23.
//


import UIKit



class DetailProductTitleCVCell: UICollectionViewCell {
    
    var title: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    
    private func createUI() {
        title = UILabel()
        title.text = "--"
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 24, weight: .semibold)
        addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            title.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
}


extension DetailProductTitleCVCell: ListCell {
    func populate(data: ListCellData) {
        guard let item = data as? DetailTitleListItem else { return }
        title.text = item.title
    }
}

