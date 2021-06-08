//
//  ProductListViewController.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 6/6/2564 BE.
//

import UIKit

protocol IProductListViewControllerInput: AnyObject {
    func showProductListSuccess(products: [Product])
    func showProductListFailure(message: String)
}

protocol IProductListViewControllerOutput: AnyObject {
    func getProductList()
}

final class ProductListViewController: UIViewController {
    var interactor: IProductListInteractorInput?
    var router: IProductListRoutingLogic?
        
    @IBOutlet private weak var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        
        interactor?.getProductList()
    }
    
    private func setTitle() {
        self.title = "Products"
    }

}

extension ProductListViewController: IProductListViewControllerInput {
    func showProductListSuccess(products: [Product]) {
        // TODO: Update table view
        
        print("Products: \(products)")
    }
    
    func showProductListFailure(message: String) {
        // TODO: Show error message on screen
    }
}
