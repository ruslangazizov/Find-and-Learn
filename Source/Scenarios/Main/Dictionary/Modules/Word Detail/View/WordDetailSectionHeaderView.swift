//
//  WordDetailSectionHeaderView.swift
//  Find-and-Learn
//
//  Created by Руслан on 27.04.2022.
//

import UIKit

class WordDetailSectionHeaderView: UIView {
    init(text: String) {
        super.init(frame: .zero)
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.text = text
        sectionHeaderLabel.textAlignment = .center
        sectionHeaderLabel.setFontSize(18)
        
        addSubview(sectionHeaderLabel)
        sectionHeaderLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
