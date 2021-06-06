//
//  ProductRepository.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 6/6/2564 BE.
//

import Foundation

protocol IProductRepository {
    func getProductList(completion: @escaping (Result<[Product], Error>) -> Void)
}

final class ProductRepository: IProductRepository {
    private let remote: IProductRepository
    
    init(remote: IProductRepository) {
        self.remote = remote
    }
    
    func getProductList(completion: @escaping (Result<[Product], Error>) -> Void) {
        remote.getProductList(completion: completion)
    }
}
