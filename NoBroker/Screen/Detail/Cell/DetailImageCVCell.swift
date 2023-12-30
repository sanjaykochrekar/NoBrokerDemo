//
//  DetailImageCVCell.swift
//  NoBroker
//
//  Created by Sanju on 30/12/23.
//

import UIKit



class DetailImageCVCell: UICollectionViewCell {
    
    var image: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    
    private func createUI() {
        image = UIImageView()
        image.contentMode = .scaleAspectFit
        addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}


extension DetailImageCVCell: ListCell {
    func populate(data: ListCellData) {
        guard let item = data as? DetailImageListItem else { return }
        image.sd_setImage(with: URL(string:item.image), placeholderImage: UIImage(systemName: "photo"))
    }
}
