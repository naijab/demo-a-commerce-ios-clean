//
//  ProductListSnapshot.swift
//  A-CommerceTests
//
//  Created by Nattapon.Pon on 5/7/2564 BE.
//

import FBSnapshotTestCase
@testable import A_Commerce

final class ProductListSnapshot: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testErrorView() {
        let errorView = ErrorView(frame: UIScreen.main.bounds)
        errorView.bindData(with: "Something about network")
        FBSnapshotVerifyView(errorView)
    }
}
