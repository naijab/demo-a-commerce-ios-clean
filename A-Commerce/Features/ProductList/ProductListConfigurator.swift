//
//  ProductListConfigurator.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 6/6/2564 BE.
//

import Foundation

protocol IProductListConfigurator {
    func configured(_ vc: ProductListViewController) -> ProductListViewController
}

final class ProductListConfigurator: IProductListConfigurator {
    
    @discardableResult
    func configured(_ vc: ProductListViewController) -> ProductListViewController {
        let remoteWorker = ProductRemoteWorker()
        let worker = ProductWorker(remote: remoteWorker)
        
        let presenter = ProductListPresenter(viewController: vc)
        
        let interactor = ProductListInteractor(
            presenter: presenter,
            productWorker: worker
        )
      
        let router = ProductListRouter(source: vc)
    
        vc.interactor = interactor
        vc.router = router
       
        return vc
    }

}
