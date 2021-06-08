//
//  ProductRemoteRepository.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 6/6/2564 BE.
//

import Foundation
import Alamofire
import ObjectMapper

final class ProductRemoteWorker: IProductWorker {
    private let baseURL = "https://ecommerce-product-app.herokuapp.com/products"
    
    func getProductDetail(with id: Int, completion: @escaping (Result<Product, Error>) -> Void) {
        AF.request("\(baseURL)/\(id)", method: .get).responseJSON { response in
            guard let _ = response.data else {
                completion(.failure(ErrorType.fetchError))
                return
            }
            let product = Mapper<Product>().map(JSONObject: response.value)
            if let product = product {
                completion(.success(product))
            }
        }
    }
    
    
    func getProductList(completion: @escaping (Result<[Product], Error>) -> Void) {
        AF.request(baseURL, method: .get).responseJSON { response in
            guard let _ = response.data else {
                completion(.failure(ErrorType.fetchError))
                return
            }
            let productList = Mapper<Product>().mapArray(JSONObject: response.value)
            if let productList = productList {
                completion(.success(productList))
            } else {
                completion(.success([]))
            }
        }
    }
}
