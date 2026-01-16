//
//  FillLabel.swift
//  SEONOrchSDK-Sample-UIKit
//
//  Created by SEON Technologies Ltd. on 02.09.25.
//  Copyright © 2026 SEON Technologies Ltd. All rights reserved.
//

import UIKit

class FillLabel: UILabel {
    override init(frame: CGRect) {
        super
            .init(frame: frame)
        setContentHuggingPriority(.defaultLow, for: .horizontal)
        textAlignment = .center
    }

    required init?(coder: NSCoder) {
        super
            .init(coder: coder)
    }
}
