//
//  ProductWorkerMock.swift
//  A-CommerceTests
//
//  Created by Nattapon Pondongnok on 9/6/2564 BE.
//
@testable import A_Commerce

final class ProductWorkerMock: IProductWorker {
    var getProductDetailCalled = false
    var getProductDetailStub: Result<Product, Error>?
    
    func getProductDetail(with id: Int, completion: @escaping (Result<Product, Error>) -> Void) {
        getProductDetailCalled = true
        if let stub = getProductDetailStub {
            completion(stub)
        }
    }
    
    var getProductListCalled = false
    var getProductListStub: Result<[Product], Error>?
    
    func getProductList(completion: @escaping (Result<[Product], Error>) -> Void) {
        getProductListCalled = true
        if let stub = getProductListStub {
            completion(stub)
        }
    }
}
