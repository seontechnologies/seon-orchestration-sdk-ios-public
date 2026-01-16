//
//  SEONCheckbox.swift
//  SEONOrchSDK
//
//  Created by Zoltán Csipler on 06/08/2024.
//

import UIKit

class SEONCheckbox: UIButton {
    // MARK: - Internal properties
    var isChecked = false {
        didSet {
            updateCheckboxAppearance()
        }
    }

    var valueChangedHandler: ((Bool) -> Void)?

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 24, height: 24)
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCheckbox()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupCheckbox()
    }

    // MARK: - Setup
    private func setupCheckbox() {
        setImage(SEONTheme.Images.Common.checkboxChecked, for: .selected)
        setImage(SEONTheme.Images.Common.checkboxUnchecked, for: .normal)

        addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)

        updateCheckboxAppearance()
    }

    // MARK: - Actions
    @objc
    private func toggleCheckbox() {
        isChecked.toggle()
        sendActions(for: .valueChanged)
        valueChangedHandler?(isChecked)
    }

    // MARK: - Update Appearance
    private func updateCheckboxAppearance() {
        self.isSelected = isChecked
    }
}
