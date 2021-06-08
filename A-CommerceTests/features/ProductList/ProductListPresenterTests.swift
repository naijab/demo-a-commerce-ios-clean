//
//  ProductListPresenterTests.swift
//  A-CommerceTests
//
//  Created by Nattapon Pondongnok on 9/6/2564 BE.
//

import XCTest
@testable import A_Commerce

final class ProductListPresenterTests: XCTestCase {
    private var sut: ProductListPresenter!
    private var vc: ProductListPresenterOutputMock!

    override func setUp() {
        super.setUp()
        
        vc = ProductListPresenterOutputMock()
        sut = ProductListPresenter(viewController: vc)
    }
    
    override func tearDown() {
        sut = nil
        vc = nil
        
        super.tearDown()
    }
    
    func test_presenter_whenShowProductListSuccess_called() {
        sut.showProductListSuccess(products: [])
        
        XCTAssertEqual(vc.showProductListSuccessData.count, 0)
        XCTAssertTrue(vc.showProductListSuccessCalled)
    }
    
    func test_presenter_whenShowProductFailure_called() {
        let expect = ErrorType.fetchError.rawValue
        sut.showProductListFailure(message: expect)
    
        XCTAssertEqual(vc.showProductListFailureData, expect)
        XCTAssertTrue(vc.showProductListFailureCalled)
    }
}

private final class ProductListPresenterOutputMock: IProductListPresenterOutput {
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
