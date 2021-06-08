//
//  ProductDetailViewController.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 8/6/2564 BE.
//

import UIKit
import Kingfisher

protocol IProductDetailViewControllerInput: AnyObject {
    func showProductDetailSuccess(product: Product)
    func showProductDetailFailure(message: String)
}

protocol IProductDetailViewControllerOutput: AnyObject {
    func getProductDetail(id: Int)
}

final class ProductDetailViewController: UIViewController {
    
    @IBOutlet private weak var productNew: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productTitle: UILabel!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var productDetail: UILabel!
    
    var interactor: IProductDetailInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setBackButton()
        setView()
    }

    private func setTitle() {
        self.title = "Detail"
    }
    
    private func setBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func setView() {
        productNew?.isHidden = true
    }

}

extension ProductDetailViewController: IProductDetailViewControllerInput {
    
    func showProductDetailSuccess(product: Product) {
        self.productTitle?.text = product.title ?? ""
        self.productPrice?.text = product.displayPrice ?? "0"
        self.productImage?.kf.setImage(
            with: URL(string: product.image ?? ""),
            placeholder: UIImage(named: "empty_photos")
        )
        self.productDetail?.text = product.content ?? ""
        self.productNew?.isHidden = !(product.isNewProduct ?? false)
    }
    
    func showProductDetailFailure(message: String) {
        print("product detail error: \(message)")
    }
    
}
