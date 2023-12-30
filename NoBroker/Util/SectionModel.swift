//
//  SectionModel.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//


struct SectionModel {
    var row: [ListCellData] = []
    
    
    mutating func append(item: ListCellData) {
        row.append(item)
    }
    
    
    mutating func append(contentsOf array: [ListCellData]) {
        row.append(contentsOf: array)
    }
    
    
    mutating func removeAll() {
        row = []
    }
    
}
