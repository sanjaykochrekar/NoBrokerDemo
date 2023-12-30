//
//  SectionViewModel.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import Foundation



protocol SectionViewModel {
    var data: [SectionModel] { get set }
}



extension SectionViewModel {
    
    func getSectionCount() -> Int {
        data.count
    }
    
    
    func getRowCount(section: Int) -> Int {
        if data.isEmpty {
            return 0
        }
        return data[section].row.count
    }
    
    
    func getItemAtIndex(indexPath: IndexPath) -> ListCellData? {
        if data.count > indexPath.section && data[indexPath.section].row.count > indexPath.row {
            return data[indexPath.section].row[indexPath.row]
        }
        return nil
    }
    
}
