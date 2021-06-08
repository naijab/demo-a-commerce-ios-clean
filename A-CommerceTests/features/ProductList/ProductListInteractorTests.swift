//
//  ProductListInteractorTests.swift
//  A-CommerceTests
//
//  Created by Nattapon Pondongnok on 9/6/2564 BE.
//

import XCTest
@testable import A_Commerce

final class ProductListInteractorTests: XCTestCase {
    private var sut: ProductListInteractor!
    private var worker: ProductWorkerMock!
    private var presenter: ProducListPresenterInputMock!
    
    override func setUp() {
        super.setUp()
        worker = ProductWorkerMock()
        presenter = ProducListPresenterInputMock()
        sut = ProductListInteractor(
            presenter: presenter,
            productWorker: worker
        )
    }
    
    override func tearDown() {
        sut = nil
        worker = nil
        presenter = nil
        
        super.tearDown()
    }
    
    func test_interactor_when_call_get_productList() {
        sut.getProductList()
        
        XCTAssertTrue(worker.getProductListCalled)
    }
    
    func test_interactor_when_call_get_productList_then_return_success() {
        let expect = expectation(description: "Wait for getProductList return")
        
        let mockResult = [
            Product(id: 1, title: "Mock", image: "https://picsum.photos/200/300", content: "content", isNewProduct: true, price: 55.5)
        ]
        worker.getProductListStub = .success(mockResult)
        
        sut.getProductList()
        
        XCTAssertTrue(presenter.showLoadingCalled)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expect.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(presenter.showProductListSuccessData.count, 1)
        XCTAssertTrue(presenter.hideLoadingCalled)
        XCTAssertTrue(presenter.showProductListSuccessCalled)
    }
    
    func test_interactor_when_call_get_productList_then_return_failure() {
        let expect = expectation(description: "Wait for getProductList return")
    
        worker.getProductListStub = .failure(ErrorType.fetchError)
        
        sut.getProductList()
        
        XCTAssertTrue(presenter.showLoadingCalled)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expect.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(presenter.showProductListFailureData, ErrorType.fetchError.rawValue)
        XCTAssertTrue(presenter.hideLoadingCalled)
        XCTAssertTrue(presenter.showProductListFailureCalled)
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
