//
//  SampleAppTextField.swift
//  SEONOrchSDK-Sample-UIKit
//
//  Created by SEON Technologies Ltd. on 02.09.25.
//  Copyright © 2026 SEON Technologies Ltd. All rights reserved.
//

import UIKit

class SampleAppTextView: UIView, UITextViewDelegate {

    // MARK: - Public Properties
    var maxNumberOfLines: Int = 8 {
        didSet {
            updateMaxHeight()
        }
    }

    var text: String {
        get { return textView.text }
        set {
            textView.text = newValue
            textViewDidChange(textView)
        }
    }

    var font = UIFont.systemFont(ofSize: 16) {
        didSet {
            textView.font = font
            updateMaxHeight()
        }
    }

    override var backgroundColor: UIColor? {
        get {
            return super.backgroundColor
        }
        set {
            super.backgroundColor = newValue

            textView.backgroundColor = newValue
        }
    }

    override var accessibilityIdentifier: String? {
        get {
            textView.accessibilityIdentifier
        }
        set {
            textView.accessibilityIdentifier = newValue
        }
    }

    // MARK: - Private Properties
    private let textView = UITextView()
    private var maxHeightConstraint: NSLayoutConstraint?
    weak var delegate: UITextViewDelegate?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupTextView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupTextView()
    }

    // MARK: - Setup
    private func setupTextView() {
        translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textView)
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.font = font
        textView.backgroundColor = .systemGray6
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)

        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        updateMaxHeight()
    }

    private func updateMaxHeight() {
        let lineHeight = font.lineHeight
        let textInsets = textView.textContainerInset.top + textView.textContainerInset.bottom
        let newMaxHeight = lineHeight * CGFloat(maxNumberOfLines) + textInsets

        if let constraint = maxHeightConstraint {
            constraint.constant = newMaxHeight
        } else {
            maxHeightConstraint = heightAnchor.constraint(
                equalToConstant: newMaxHeight
            )
            maxHeightConstraint?.isActive = true
        }

        setNeedsLayout()
        layoutIfNeeded()
    }

    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        let fittingSize = CGSize(width: textView.frame.width, height: CGFloat.infinity)
        let size = textView.sizeThatFits(fittingSize)

        textView.isScrollEnabled = size.height > (maxHeightConstraint?.constant ?? 0)
        delegate?.textViewDidChange?(textView)
    }
}
