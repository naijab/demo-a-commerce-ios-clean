//
//  ProductListWorker.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 6/6/2564 BE.
//

import Foundation

protocol IProductWorker {
    func getProductList(completion: @escaping (Result<[Product], Error>) -> Void)
}

final class ProductWorker: IProductWorker {
    private let remote: IProductWorker
    
    init(remote: IProductWorker) {
        self.remote = remote
    }
    
    func getProductList(completion: @escaping (Result<[Product], Error>) -> Void) {
        remote.getProductList(completion: completion)
    }
}
