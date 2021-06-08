//
//  ProductListPresenter.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 6/6/2564 BE.
//

import Foundation

typealias IProductListPresenterInput = IProductListInteractorOutput
typealias IProductListPresenterOutput = IProductListViewControllerInput

final class ProductListPresenter {
    weak var viewController: IProductListPresenterOutput?
    
    init(viewController: IProductListPresenterOutput) {
        self.viewController = viewController
    }
}

extension ProductListPresenter: IProductListPresenterInput {
    
    func showProductListSuccess(products: [Product]) {
        viewController?.showProductListSuccess(products: products)
    }
    
    func showProductListFailure(message: String) {
        viewController?.showProductListFailure(message: message)
    }
    
}
