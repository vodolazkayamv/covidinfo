//
//  CaptionedLabel.swift
//  covidInfo
//
//  Created by Masha Vodolazkaya on 30/03/2020.
//  Copyright © 2020 Мария Водолазкая. All rights reserved.
//

import Foundation
import UIKit

class CaptionedLabel: UIStackView {
    
    var caption : String
    var content : String
    var attributedContent : NSAttributedString
    
    init(caption: String, text: String, bold: Bool = false) {

        self.caption = caption
        self.content = text
        self.attributedContent = NSAttributedString(string: "")
        
        super.init(frame: .zero)

        let label : UILabel = UILabel()
        label.text = text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        if (bold) {
            label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        } else {
            label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        }
        
        let captionLabel = UILabel()
        captionLabel.text = caption
        captionLabel.font = .systemFont(ofSize: 8, weight: .thin)
        captionLabel.textAlignment = .center
        
        self.addArrangedSubview(captionLabel)
        self.addArrangedSubview(label)
        
        self.axis = .vertical
        self.spacing = 2
    }
    
    init(caption: String, text: NSAttributedString) {

        self.caption = caption
        self.content = ""
        self.attributedContent = text
        
        super.init(frame: .zero)

        let label : UILabel = UILabel()
        label.attributedText = text
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let captionLabel = UILabel()
        captionLabel.text = caption
        captionLabel.font = .systemFont(ofSize: 8, weight: .thin)
        captionLabel.textAlignment = .center
        
        self.addArrangedSubview(captionLabel)
        self.addArrangedSubview(label)
        
        self.axis = .vertical
        self.spacing = 2
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
