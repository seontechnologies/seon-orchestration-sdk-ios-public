//
//  KeyboardAwareVC.swift
//  SEONOrchSDK-Sample-UIKit
//
//  Created by SEON Technologies Ltd. on 02.09.25.
//  Copyright © 2026 SEON Technologies Ltd. All rights reserved.
//

import UIKit

class KeyboardAwareVC: UIViewController {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let contentView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.axis = .vertical
        contentView.alignment = .fill
        contentView.distribution = .fill
        contentView.spacing = 8
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            ),
            scrollView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            contentView.topAnchor.constraint(
                equalTo: scrollView.topAnchor
            ),
            contentView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor
            ),
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor
            ),
            contentView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor
            ),
            contentView.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor
            )
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }

        let keyboardHeight = keyboardFrame.height

        scrollView.contentInset.bottom = keyboardHeight
        if #available(iOS 13.0, *) {
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        } else {
            scrollView.scrollIndicatorInsets.bottom = keyboardHeight
        }

        // Optional: animate with keyboard
        if let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
           let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: UIView.AnimationOptions(rawValue: curve << 16),
                           animations: {
                self.view.layoutIfNeeded()
            })
        }

        scrollToActiveField()
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        if #available(iOS 13.0, *) {
            scrollView.verticalScrollIndicatorInsets.bottom = 0
        } else {
            scrollView.scrollIndicatorInsets.bottom = 0
        }
    }

    private func scrollToActiveField() {
        if let activeField = view.currentFirstResponder {
            let fieldFrameInScroll = scrollView.convert(activeField.bounds, from: activeField)
            scrollView.scrollRectToVisible(fieldFrameInScroll.insetBy(dx: 0, dy: -20), animated: true)
        }
    }
}

extension UIView {
    var currentFirstResponder: UIView? {
        if self.isFirstResponder {
            return self
        }

        for subview in self.subviews {
            if let responder = subview.currentFirstResponder {
                return responder
            }
        }
        return nil
    }
}
