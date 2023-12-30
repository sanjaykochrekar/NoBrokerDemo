//
//  ListCell.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//



protocol ListCell {
    func populate(data: ListCellData)
}



extension ListCell {
    func populate(data: ListCellData) {}
}



protocol ListCellData {
    var identifier: String { get set }
}
