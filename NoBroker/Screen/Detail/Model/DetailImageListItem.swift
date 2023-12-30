//
//  DetailImageListItem.swift
//  NoBroker
//
//  Created by Sanju on 30/12/23.
//

import Foundation


struct DetailImageListItem: ListCellData {
    var identifier: String = "DetailImageCVCell"
    let image: String
}


struct DetailTitleListItem: ListCellData {
    var identifier: String = "DetailProductTitleCVCell"
    var title: String
}

struct DetailDescription: ListCellData {
    var identifier: String = "DetailProductDescriptionCVCell"
    var description: String
}
