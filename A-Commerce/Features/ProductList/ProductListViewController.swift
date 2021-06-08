//
//  ProductListViewController.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 6/6/2564 BE.
//

import UIKit

protocol IProductListViewControllerInput: AnyObject {
    func showLoading()
    func hideLoading()
    func showProductListSuccess(products: [Product])
    func showProductListFailure(message: String)
}

protocol IProductListViewControllerOutput: AnyObject {
    func getProductList()
}

final class ProductListViewController: UIViewController {
    @IBOutlet private weak var errorView: ErrorView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    private var products: [Product] = []
    
    var interactor: IProductListInteractorInput?
    var router: IProductListRoutingLogic?
        
    @IBOutlet private weak var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setCollectionView()
        setLoadingIndicator()
        setErrorView()
        
        interactor?.getProductList()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        productCollectionView?.collectionViewLayout.invalidateLayout()
    }
    
    private func setTitle() {
        self.title = "Products"
    }
    
    private func setCollectionView() {
        productCollectionView?.register(
            ProductCollectionViewCell.nib(),
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
        productCollectionView?.delegate = self
        productCollectionView?.dataSource = self
        productCollectionView?.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    private func setLoadingIndicator() {
        loadingIndicator?.isHidden = true
    }
    
    private func setErrorView() {
        errorView?.isHidden = true
        errorView?.delegate = self
    }
}

extension ProductListViewController: IProductListViewControllerInput {
    func showLoading() {
        loadingIndicator?.isHidden = false
        loadingIndicator?.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator?.isHidden = true
        loadingIndicator?.stopAnimating()
    }
    
    func showProductListSuccess(products: [Product]) {
        self.products = products
        productCollectionView?.reloadData()
        errorView?.isHidden = true
    }
    
    func showProductListFailure(message: String) {
        errorView?.isHidden = false
        errorView?.bindData(with: message)
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.identifier,
            for: indexPath
        ) as! ProductCollectionViewCell
        
        cell.bindData(with: products[indexPath.row])

        return cell
    }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameWidth = collectionView.bounds.width
        
        let itemWidth = (frameWidth / 2) - 3
        let itemHeight = frameWidth * 0.65
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = products[indexPath.row].id {
            router?.showProductDetail(id: id)
        }
    }
}

extension ProductListViewController: ErrorViewDelegate {
    func didTryAgainTap(_ view: ErrorView) {
        interactor?.getProductList()
    }
}
