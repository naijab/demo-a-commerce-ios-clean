//
//  ProductListRouter.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 6/6/2564 BE.
//

import UIKit

protocol IProductListRoutingLogic {
    func showProductDetail(id: Int)
}

final class ProductListRouter {
    weak var source: UIViewController?
    
    init(source: UIViewController) {
        self.source = source
    }
}

extension ProductListRouter: IProductListRoutingLogic {
    
    func showProductDetail(id: Int) {
        let productDetailConfigurator = ProductDetailConfigurator(input: ProductDetailConfiguratorInput(id: id))
        let viewController = productDetailConfigurator.configured(ProductDetailViewController())
        source?.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
