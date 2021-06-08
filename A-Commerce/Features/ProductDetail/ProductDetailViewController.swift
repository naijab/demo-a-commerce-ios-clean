//
//  ProductDetailViewController.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 8/6/2564 BE.
//

import UIKit
import Kingfisher

protocol IProductDetailViewControllerInput: AnyObject {
    func showLoading()
    func hideLoading()
    func showProductDetailSuccess(product: Product)
    func showProductDetailFailure(message: String)
}

protocol IProductDetailViewControllerOutput: AnyObject {
    func getProductDetail(id: Int)
}

final class ProductDetailViewController: UIViewController {
    @IBOutlet private weak var errorView: ErrorView!
    @IBOutlet private weak var productNew: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productTitle: UILabel!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var productDetail: UILabel!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    var id: Int?
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
        setShowProductDetail(false)
        errorView.isHidden = true
        loadingIndicator?.isHidden = true
    }
}

extension ProductDetailViewController: IProductDetailViewControllerInput {
    func showLoading() {
        loadingIndicator?.isHidden = false
        loadingIndicator?.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator?.isHidden = true
        loadingIndicator?.stopAnimating()
    }
    
    func showProductDetailSuccess(product: Product) {
        productTitle.text = product.title ?? ""
        productPrice.text = product.displayPrice ?? "0"
        productImage.kf.setImage(
            with: URL(string: product.image ?? ""),
            placeholder: UIImage(named: "empty_photos")
        )
        productDetail.text = product.content ?? ""
        productNew.isHidden = !(product.isNewProduct ?? false)
        
        setShowProductDetail(true)
        
        errorView.isHidden = true
    }
    
    func showProductDetailFailure(message: String) {
        setShowProductDetail(false)
        
        errorView.isHidden = false
        errorView.bindData(with: message)
    }
    
    private func setShowProductDetail(_ isShow: Bool) {
        productTitle.isHidden = !isShow
        productPrice.isHidden = !isShow
        productImage.isHidden = !isShow
        productNew.isHidden = !isShow
        productDetail.isHidden = !isShow
    }
}

extension ProductDetailViewController: ErrorViewDelegate {
    func didTryAgainTap(_ view: ErrorView) {
        if let id = id {
            interactor?.getProductDetail(id: id)
        }
    }
}
