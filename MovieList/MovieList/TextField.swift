//
//  TextField.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import UIKit

class TextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemPurple.cgColor // border colours require UIColor; when dealing with layer you need .cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2) // dynamic type
        adjustsFontSizeToFitWidth = true // if the text is long, it will shrink to fit
        minimumFontSize = 12 // the text can shrink but only down to 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .default
        returnKeyType = .search
        clearButtonMode = .whileEditing
        placeholder = "Enter a movie name"
    }
}
