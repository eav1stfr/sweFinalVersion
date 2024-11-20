//
//  ButtonView.swift
//  FarmersMarketProject
//
//  Created by Александр Эм on 18.10.2024.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        layer.cornerRadius = 20
        titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
