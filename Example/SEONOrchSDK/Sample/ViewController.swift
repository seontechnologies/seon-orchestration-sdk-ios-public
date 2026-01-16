//
//  AppDelegate.swift
//  SEONOrchSDKSample
//
//  Created by SEON Technologies Ltd. on 02.04.25.
//  Copyright © 2026 SEON Technologies Ltd. All rights reserved.
//

import SEONOrchSDK
import UIKit

class ViewController: KeyboardAwareVC, UINavigationControllerDelegate {

    // MARK: - ViewModel
    private let viewModel = MainViewModel()
    private let languageTextField = SampleAppTextField()
    private let customizeThemeCheckmark = SEONCheckbox()
    private let themeTextView = SampleAppTextView()
    private let sessionTokenTextField = SampleAppTextField()
    private let cmsApiKeyTextField = SampleAppTextField()
    private let flowResultLabel = FillLabel()
    private let navigateButton = UIButton(type: .system)

    // Container views for animation
    private let sessionTokenContainer = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray

        setUpTitle()
        setUpLanguageField()
        setUpThemeTextView()
        setUpSessionTokenContainer()
        setUpFlowTableTitleAndLabel()
        setUpNavigationButton()
        applyPersistedSettings()

        contentView.setCustomSpacing(18, after: languageTextField)
        contentView.setCustomSpacing(18, after: themeTextView)
        contentView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(tappedBackgroundArea))
        )
        // Set up tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedBackgroundArea))
        view.addGestureRecognizer(tapGesture)
    }

    @objc
    private func tappedBackgroundArea() {
        contentView.endEditing(true)
    }

    private func setUpTitle() {
        let titleLabel = FillLabel()
        titleLabel.text = "Test Application"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(titleLabel)

        initializeDefaultJSONs()
    }

    private func initializeDefaultJSONs() {
        initializeThemeJSON()
    }

    private func initializeThemeJSON() {
        themeTextView.text = viewModel.getDefaultThemeJSON()
    }

    private func setUpLanguageField() {
        let langLabel = FillLabel()
        langLabel.text = "Language:"
        langLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(langLabel)

        languageTextField.backgroundColor = .systemGray6
        languageTextField.delegate = self
        languageTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(languageTextField)
    }

    private func setUpThemeTextView() {
        let themeLabel = FillLabel()
        themeLabel.text = "Theme:"
        themeLabel.translatesAutoresizingMaskIntoConstraints = false

        themeTextView.isUserInteractionEnabled = false
        themeTextView.backgroundColor = .systemGray2
        themeTextView.delegate = self

        contentView.addArrangedSubview(themeLabel)
        contentView.addArrangedSubview(setupCustomizeThemeCheckmark())
        contentView.addArrangedSubview(themeTextView)
    }

    private func setUpSessionTokenContainer() {

        // Setup session token container (shown when unchecked)
        setupSessionTokenContainer()
        contentView.addArrangedSubview(sessionTokenContainer)
        sessionTokenContainer.isHidden = false
    }

    private func setupCustomizeThemeCheckmark() -> UIView {
        let emptySpacer = UIView()
        emptySpacer.translatesAutoresizingMaskIntoConstraints = false
        let themeLabel = UILabel()
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        themeLabel.text = "Customize Theme"

        let checkbox = customizeThemeCheckmark
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.valueChangedHandler = { [weak self] (isChecked: Bool) in
            self?.applyCustomizeTheme(isChecked: isChecked)
        }

        emptySpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        emptySpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        let themeStackView = UIStackView(arrangedSubviews: [emptySpacer, checkbox, themeLabel])
        themeStackView.axis = .horizontal
        themeStackView.spacing = 6
        themeStackView.alignment = .leading
        themeStackView.distribution = .fill
        themeStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(themeStackView)

        return themeStackView
    }

    private func setupSessionTokenContainer() {
        sessionTokenContainer.axis = .vertical
        sessionTokenContainer.spacing = 8
        sessionTokenContainer.translatesAutoresizingMaskIntoConstraints = false

        let sessionTokenLabel = FillLabel()
        sessionTokenLabel.text = "Session Token:"
        sessionTokenLabel.translatesAutoresizingMaskIntoConstraints = false

        sessionTokenTextField.backgroundColor = .systemGray6
        sessionTokenTextField.delegate = self
        sessionTokenTextField.placeholder = "Paste JWT token here"
        sessionTokenTextField.translatesAutoresizingMaskIntoConstraints = false

        sessionTokenContainer.addArrangedSubview(sessionTokenLabel)
        sessionTokenContainer.addArrangedSubview(sessionTokenTextField)
    }

    private func setUpFlowTableTitleAndLabel() {
        let flowResultTitleLabel = FillLabel()
        flowResultTitleLabel.text = "Flow result:"

        flowResultTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(flowResultTitleLabel)

        // Flow result label
        flowResultLabel.text = ""
        flowResultLabel.numberOfLines = 0
        flowResultLabel.textAlignment = .center

        flowResultLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(flowResultLabel)
    }

    private func setUpNavigationButton() {
        navigateButton.setTitle("Start Verification", for: .normal)
        navigateButton.backgroundColor = .red
        navigateButton.setTitleColor(.white, for: .normal)
        navigateButton.layer.cornerRadius = 16
        navigateButton.addTarget(self, action: #selector(navigateButtonTapped), for: .touchUpInside)

        navigateButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(navigateButton)
        NSLayoutConstraint.activate([
            navigateButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func applyPersistedSettings() {

        languageTextField.text = "en"
        themeTextView.text = viewModel.getDefaultThemeJSON()
        sessionTokenTextField.text = "YOUR_SESSION_TOKEN"

        customizeThemeCheckmark.isChecked = false
        applyCustomizeTheme(isChecked: customizeThemeCheckmark.isChecked)
    }

    private func applyCustomizeTheme(isChecked: Bool) {
        themeTextView.isUserInteractionEnabled = isChecked
        themeTextView.backgroundColor = isChecked ? .systemGray6 : .systemGray2
    }

    @objc
    func navigateButtonTapped() {
        guard let navController = navigationController else { return }

        navController.delegate = self
        flowResultLabel.text = ""

        // Get language from text field
        var language: String?
        if let languageText = languageTextField.text, !languageText.isEmpty {
            language = languageText
        }

        // Only pass theme if customize theme is enabled
        let themeToUse = customizeThemeCheckmark.isChecked ? themeTextView.text : nil

        // Use ViewModel to handle SDK initialization
        viewModel.initializeSDK(
            sessionToken: sessionTokenTextField.text,
            language: language,
            theme: themeToUse,
            navigationController: navController,
            delegate: self
        )
    }

    private func showError(_ value: String) {
        let alert = UIAlertController(
            title: "Initialization Failed",
            message: value,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

extension ViewController: SEONOrchSDKServiceDelegate {
    func didFinishVerificationFlow(result: SEONOrchSDK.SEONOrchSDKFlowResult) {
        flowResultLabel.textColor = result.getResultIndicationColor()
        flowResultLabel.text = result.getResultIndicatorText()
    }
}

extension ViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
