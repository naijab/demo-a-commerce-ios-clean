//
//  ProductListInteractor.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 6/6/2564 BE.
//

import Foundation

typealias IProductListInteractorInput = IProductListViewControllerOutput

protocol IProductListInteractorOutput: AnyObject {
    func showProductListSuccess(products: [Product])
    func showProductListFailure(message: String)
}

final class ProductListInteractor {
    var presenter: IProductListPresenterInput?
    var productListWorker: ProductListWorker?
}

extension ProductListInteractor: IProductListInteractorInput {
    
    func getProductList() {
        productListWorker?.getProductList { [self] result in
            switch result {
            case .failure(let error):
                presenter?.showProductListFailure(message: error.localizedDescription)
            case .success(let products):
                presenter?.showProductListSuccess(products: products)
            }
        }
    }
    
}

