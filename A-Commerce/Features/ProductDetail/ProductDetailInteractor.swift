//
//  ProductDetailInteractor.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 8/6/2564 BE.
//

import Foundation

typealias IProductDetailInteractorInput = IProductDetailViewControllerOutput

protocol IProductDetailInteractorOutput: AnyObject {
    func showProductDetailSuccess(product: Product)
    func showProductDetailFailure(message: String)
}

final class ProductDetailInteractor {
    let presenter: IProductDetailPresenterInput?
    let productWorker: IProductWorker?
    
    init(
        presenter: IProductDetailPresenterInput,
        productWorker: IProductWorker
    ) {
        self.presenter = presenter
        self.productWorker = productWorker
    }
}

extension ProductDetailInteractor: IProductDetailInteractorInput {
    func getProductDetail(id: Int) {
        productWorker?.getProductDetail(with: id) { [self] result in
            switch result {
            case .failure(let error):
                presenter?.showProductDetailFailure(message: error.localizedDescription)
            case .success(let product):
                presenter?.showProductDetailSuccess(product: product)
            }
        }
    }
}

