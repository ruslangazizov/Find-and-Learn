//
//  FieldStackView.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import UIKit

// TODO: (r.akhmadeev) Нет смысла плодить новую сущность, не наделяя ее новым поведением. Простую конфигурацию можно вынести в extension
final class FieldStackView: UIStackView {
    init(titleView: UIView, fieldView: UIView, spacing: CGFloat) {
        super.init(frame: .zero)
        
        axis = .vertical
        self.spacing = spacing
        addArrangedSubviews([titleView, fieldView])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
