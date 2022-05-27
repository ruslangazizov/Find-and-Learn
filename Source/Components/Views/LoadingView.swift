//
//  LoadingView.swift
//  Find-and-Learn
//
//  Created by Руслан on 27.05.2022.
//

import UIKit

final class LoadingView: UIView {
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    init() {
        super.init(frame: .zero)
        
        configureView()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        isHidden = true
        backgroundColor = R.color.defaultBackgroundColor()
        layer.cornerRadius = .cornerRadius
        layer.borderWidth = .borderWidth
        layer.borderColor = .borderColor
    }
    
    private func setupSubviews() {
        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
    
    func showSpinner() {
        activityIndicatorView.startAnimating()
        isHidden = false
    }
    
    func hideSpinner() {
        activityIndicatorView.stopAnimating()
        isHidden = true
    }
}

private extension CGFloat {
    static let cornerRadius: CGFloat = 16
    static let borderWidth: CGFloat = 1
}

private extension CGColor {
    static let borderColor: CGColor = UIColor.gray.cgColor
}
