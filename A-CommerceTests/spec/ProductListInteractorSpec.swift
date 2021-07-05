//
//  TestSpec.swift
//  A-CommerceTests
//
//  Created by Nattapon.Pon on 5/7/2564 BE.
//

import Quick
import Nimble
@testable import A_Commerce

final class ProductListInteractorSpec: QuickSpec {
    override func spec() {
        describe("Product List Interactor") {
            var sut: ProductListInteractor!
            var worker: ProductWorkerMock!
            var presenter: ProducListPresenterInputMock!
            
            beforeSuite {
                worker = ProductWorkerMock()
                presenter = ProducListPresenterInputMock()
                sut = ProductListInteractor(
                    presenter: presenter,
                    productWorker: worker
                )
            }
            
            afterSuite {
                sut = nil
                worker = nil
                presenter = nil
            }
            
            context("When fetch product list from API") {
                it("called function getProductList") {
                    sut.getProductList()
                    
                    expect(worker.getProductListCalled) == true
                }
                
                it("if success must return Product List") {
                    let mockResult = [
                        Product(
                            id: 1,
                            title: "Mock",
                            image: "https://picsum.photos/200/300",
                            content: "content",
                            isNewProduct: true,
                            price: 55.5
                        )
                    ]
                    worker.getProductListStub = .success(mockResult)
                    
                    sut.getProductList()
                    
                    expect(presenter.showLoadingCalled) == true
                    
                    expect(presenter.showProductListSuccessData.count) == 1
                    
                    expect(presenter.hideLoadingCalled) == true
                    
                    expect(presenter.showProductListSuccessCalled)  == true
                }
                
                it("if failure must return error") {
                    worker.getProductListStub = .failure(ErrorType.fetchError)
                    
                    sut.getProductList()
                    
                    expect(presenter.showLoadingCalled) == true
                    
                    expect(presenter.showProductListFailureData) == ErrorType.fetchError.rawValue
                    
                    expect(presenter.hideLoadingCalled) == true
                    
                    expect(presenter.showProductListFailureCalled) == true
                }
            }
        }
    }
}

private final class ProducListPresenterInputMock: IProductListPresenterInput {
    var showLoadingCalled = false
    var showLoadingData: Bool!
    
    func showLoading() {
        showLoadingCalled = true
        showLoadingData = true
    }
    
    var hideLoadingCalled = false
    var hideLoadingData: Bool!
    
    func hideLoading() {
        hideLoadingCalled = true
        hideLoadingData = false
    }
    
    var showProductListSuccessCalled = false
    var showProductListSuccessData: [Product]!
    
    func showProductListSuccess(products: [Product]) {
        showProductListSuccessCalled = true
        showProductListSuccessData = products
    }
    
    var showProductListFailureCalled = false
    var showProductListFailureData: String!
    
    func showProductListFailure(message: String) {
        showProductListFailureCalled = true
        showProductListFailureData = message
    }
}
