//
//  ProductCollectionViewCell.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 8/6/2564 BE.
//

import UIKit
import Kingfisher

final class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProductCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ProductCollectionViewCell", bundle: nil)
    }

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var productTitle: UILabel!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productNew: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(with data: Product) {
        productTitle?.text = data.title ?? ""
        productPrice?.text = data.displayPrice ?? "0"
        productImage?.kf.setImage(
            with: URL(string: data.image ?? ""),
            placeholder: UIImage(named: "empty_photos")
        )
        productNew?.isHidden = !(data.isNewProduct ?? false)
    }

}
