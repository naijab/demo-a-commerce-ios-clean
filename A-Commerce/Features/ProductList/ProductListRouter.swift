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
}

extension ProductListRouter: IProductListRoutingLogic {
    
    func showProductDetail(id: Int) {
        // TODO: Open product detail
    }
    
}
