//
//  DetailVM.swift
//  NoBroker
//
//  Created by Sanju on 30/12/23.
//



class DetailVM: SectionViewModel {
    var data: [SectionModel] = []
    
    
    //TODO: Since the data getting from Home screen as Detail screen used same data
    
    init(product: Product) {
        let imageList = product.images.map { DetailImageListItem(image: $0) }
        let imageSection = SectionModel(row: imageList)
        data.append(imageSection)
        
        
        let title = DetailTitleListItem(title: product.title)
        let description = DetailDescription(description: product.description)
        
        let brand  = DetailDescription(description: "BRAND:  \(product.brand)")
        
        let price = DetailDescription(description: "PRICE:  \(product.price)")
        
        let discountPercentage = DetailDescription(description: "DISCOUNT:  \(product.discountPercentage)%")
        
        let rating = DetailDescription(description: "RATING:  \(product.rating)%")
     
        let infoSection = SectionModel(row: [title, description, brand, price, discountPercentage, rating])
        data.append(infoSection)
        
    }
    
}
