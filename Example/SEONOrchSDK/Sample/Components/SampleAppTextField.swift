//
//  SampleAppTextField.swift
//  SEONOrchSDK-Sample-UIKit
//
//  Created by SEON Technologies Ltd. on 02.09.25.
//  Copyright © 2026 SEON Technologies Ltd. All rights reserved.
//

import UIKit

class SampleAppTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setUp()
    }

    private func setUp() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40)
        ])

        // Add left padding
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: frame.height))
        leftView = leftPaddingView
        leftViewMode = .always

        // Add right padding
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: frame.height))
        rightView = rightPaddingView
        rightViewMode = .always
    }
}
