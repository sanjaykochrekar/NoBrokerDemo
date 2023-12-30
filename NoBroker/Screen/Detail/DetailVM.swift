//
//  DetailVM.swift
//  NoBroker
//
//  Created by Sanju on 30/12/23.
//



class DetailVM: SectionViewModel {
    var data: [SectionModel] = []
    
    let product: Product!
    
    
    init(product: Product) {
        self.product = product
        
        let imageList = product.images.map { DetailImageListItem(image: $0) }
        let imageSection = SectionModel(row: imageList)
        data.append(imageSection)
        
        
        let title = DetailTitleListItem(title: product.title)
        let description = DetailDescription(description: product.description)
     
        let infoSection = SectionModel(row: [title, description])
        data.append(infoSection)
        
        
    }
    
    
    
}
