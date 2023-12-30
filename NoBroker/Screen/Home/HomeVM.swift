//
//  HomeVM.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import APIManager



protocol HomeVMDelegate: AnyObject {
    func reloadTableView()
}



class HomeVM: SectionViewModel {
    
    var data: [SectionModel] = [SectionModel(row: [])]
    var continueLoading = true
    var isSearching = false
    weak var delegate: HomeVMDelegate?

    
    private var allProduct: [Product] = []
    private var searchedProduct: [Product] = []
    private var allProductTask: Task<(), Never>?
    private var searchTask: Task<(), Never>?
    
    
    
    func fetchData() {
        let request = ProductListRequest(lastId: getLastItemIdForAllProduct())
        
        if allProductTask != nil {
            allProductTask?.cancel()
        }
        
        allProductTask = Task {
            let (resp, error) = await APIManager.shared.fetch(request: request, model: ProductResponseModel.self)
            if error == nil {
                if let resp, resp.products.isEmpty {
                    continueLoading = false
                }
                allProduct.append(contentsOf: resp?.products ?? [])
                setProductToDisplay(list: allProduct)
            }
        }
        
    }
    
    
    func cancelSearch() {
        setProductToDisplay(list: allProduct)
        isSearching = false
        delegate?.reloadTableView()
    }
    
    
    func searchProduct(_ text: String) {
        isSearching = true
        let request = ProductSearchRequest(search: text)
        
        if searchTask != nil {
            searchTask?.cancel()
        }
        
        searchTask = Task {
            let (searchResp, error) = await APIManager.shared.fetch(request: request, model: ProductResponseModel.self)
            if error == nil {
                if let searchResp, searchResp.products.isEmpty {
                    continueLoading = false
                }
                searchedProduct = searchResp?.products ?? []
                setProductToDisplay(list: searchedProduct)
            }
        }
    }
    
    
    private func setProductToDisplay(list: [Product]) {
        data = []
        data.append(SectionModel(row: list))
        delegate?.reloadTableView()
    }
    
    
    private func getLastItemIdForAllProduct() -> Int {
        guard let lastProduct = allProduct.last else { return 0 }
        return lastProduct.id
    }
    
}
