//
//  ErrorView.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 9/6/2564 BE.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTryAgainTap(_ view: ErrorView)
}

final class ErrorView: UIView {
    let identifier = "ErrorView"
    
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var tryAgainButton: UIButton!
    
    weak var delegate: ErrorViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
        
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }

    @IBAction func didTryAgainTap(_ params: Any) {
        delegate?.didTryAgainTap(self)
    }
    
    func bindData(with data: String) {
        errorLabel?.text = data
    }
}


