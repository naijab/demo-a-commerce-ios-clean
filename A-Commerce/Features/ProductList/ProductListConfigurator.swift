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
        let remoteRepo = ProductRemoteRepository()
        let repo = ProductRepository(remote: remoteRepo)
        let worker = ProductListWorker(repo: repo)
        let interactor = ProductListInteractor()
        let presenter = ProductListPresenter()
        let router = ProductListRouter()
        
        router.source = vc

        presenter.viewController = vc
        
        interactor.presenter = presenter
        interactor.productListWorker = worker
        
        vc.router = router
        vc.interactor = interactor
       
        return vc
    }

}
