//
//  ProductDetailConfigurator.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 8/6/2564 BE.
//

import Foundation

struct ProductDetailConfiguratorInput {
    let id: Int
}

protocol IProductDetailConfigurator {
    func configured(_ vc: ProductDetailViewController) -> ProductDetailViewController
}

final class ProductDetailConfigurator: IProductDetailConfigurator {
    private let input: ProductDetailConfiguratorInput
    
    init(input: ProductDetailConfiguratorInput) {
        self.input = input
    }
    
    @discardableResult
    func configured(_ vc: ProductDetailViewController) -> ProductDetailViewController {
        let remoteWorker = ProductRemoteWorker()
        let worker = ProductWorker(remote: remoteWorker)
        
        let presenter = ProductDetailPresenter(viewController: vc)
        
        let interactor = ProductDetailInteractor(
            presenter: presenter,
            productWorker: worker
        )
    
        vc.interactor = interactor
        vc.id = input.id
        
        interactor.getProductDetail(id: input.id)
        
        return vc
    }
}
