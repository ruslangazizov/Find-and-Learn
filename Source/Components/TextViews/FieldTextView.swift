//
//  FieldTextView.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import UIKit

// TODO: (r.akhmadeev) Нет смысла плодить новую сущность, не наделяя ее новым поведением. Простую конфигурацию можно вынести в extension
final class FieldTextView: UITextView {
    init(borderColor: CGColor, cornerRadius: CGFloat, borderWidth: CGFloat) {
        super.init(frame: .zero, textContainer: nil)
        
        backgroundColor = R.color.defaultBackgroundColor()
        isScrollEnabled = false
        font = .preferredFont(forTextStyle: .callout)
        textAlignment = .center
        
        layer.borderColor = borderColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
