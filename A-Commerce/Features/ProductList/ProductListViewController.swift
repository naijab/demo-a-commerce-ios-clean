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
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    private var products: [Product] = []
    
    var interactor: IProductListInteractorInput?
    var router: IProductListRoutingLogic?
        
    @IBOutlet private weak var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setCollectionView()
        interactor?.getProductList()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        productCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setTitle() {
        self.title = "Products"
    }
    
    private func setCollectionView() {
        productCollectionView.register(
            ProductCollectionViewCell.nib(),
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    private func setLoadingIndicator() {
        loadingIndicator.isHidden = true
    }

}

extension ProductListViewController: IProductListViewControllerInput {
    
    func showLoading() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
    }
    
    func showProductListSuccess(products: [Product]) {
        self.products = products
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
    
    func showProductListFailure(message: String) {
        // TODO: Show error message on screen
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
        var columns: CGFloat
        
        // FXIME: Calculate collection view columns at 2 column when portrait
        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            columns = 4
        } else {
            columns = 3
        }
        
        let spacing: CGFloat = 5
        
        let totalHorizontalSpacing = (columns - 1) * spacing
        
        let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / spacing
        
        return CGSize(width: itemWidth, height: itemWidth * 1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = products[indexPath.row].id {
            router?.showProductDetail(id: id)
        }
    }
}
