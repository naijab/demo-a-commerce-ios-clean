//
//  ProductDetailPresenter.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 8/6/2564 BE.
//

import Foundation

typealias IProductDetailPresenterInput = IProductDetailInteractorOutput
typealias IProductDetailPresenterOutput = IProductDetailViewControllerInput

final class ProductDetailPresenter {
    weak var viewController: IProductDetailPresenterOutput?
    
    init(viewController: IProductDetailPresenterOutput) {
        self.viewController = viewController
    }
}

extension ProductDetailPresenter: IProductDetailPresenterInput {
    func showLoading() {
        viewController?.showLoading()
    }
    
    func hideLoading() {
        viewController?.hideLoading()
    }

    func showProductDetailSuccess(product: Product) {
        viewController?.showProductDetailSuccess(product: product)
    }
    
    func showProductDetailFailure(message: String) {
        viewController?.showProductDetailFailure(message: message)
    }
}
