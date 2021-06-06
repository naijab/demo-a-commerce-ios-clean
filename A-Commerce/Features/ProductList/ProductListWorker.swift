//
//  ProductListWorker.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 6/6/2564 BE.
//

import Foundation

protocol IProductListWorker {
    func getProductList(completion: @escaping (Result<[Product], Error>) -> Void)
}

final class ProductListWorker: IProductListWorker {
    private let repo: IProductRepository
    
    init(repo: IProductRepository) {
        self.repo = repo
    }
    
    func getProductList(completion: @escaping (Result<[Product], Error>) -> Void) {
        repo.getProductList(completion: completion)
    }
    
}

