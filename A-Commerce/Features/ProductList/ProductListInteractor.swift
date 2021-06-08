//
//  ProductListInteractor.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 6/6/2564 BE.
//

import Foundation

typealias IProductListInteractorInput = IProductListViewControllerOutput

protocol IProductListInteractorOutput: AnyObject {
    func showLoading()
    func hideLoading()
    func showProductListSuccess(products: [Product])
    func showProductListFailure(message: String)
}

final class ProductListInteractor {
    let presenter: IProductListPresenterInput?
    let productWorker: IProductWorker?
    
    init(
        presenter: IProductListPresenterInput,
        productWorker: IProductWorker
    ) {
        self.presenter = presenter
        self.productWorker = productWorker
    }
}

extension ProductListInteractor: IProductListInteractorInput {
    func getProductList() {
        presenter?.showLoading()
        productWorker?.getProductList { [self] result in
            switch result {
            case .failure(let error):
                presenter?.hideLoading()
                presenter?.showProductListFailure(message: error.localizedDescription)
            case .success(let products):
                presenter?.hideLoading()
                presenter?.showProductListSuccess(products: products)
            }
        }
    }
}

