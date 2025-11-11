//
//  AppDelegate.swift
//  SEONOrchSDKSample
//
//  Created by SEON Technologies Ltd. on 02.04.25.
//  Copyright © 2025 SEON Technologies Ltd. All rights reserved.
//

import SEONIdVerification
import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    private let licenseKeyTextField = UITextField()
    private let baseUrlTextField = UITextField()
    private let templateIdTextField = UITextField()
    private let nameTextField = UITextField()
    private let dateOfBirthField = UIDatePicker()
    private let addressTextField = UITextField()
    private let postalCodeTextField = UITextField()
    private let countryTextField = UITextField()
    private let flowResultLabel = FillLabel()
    private let clearButton = UIButton()
    private let dobMaskView = UIView()
    private let contentView = UIStackView()

    var hasDoB = false {
        didSet {
            dobMaskView.isHidden = hasDoB
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
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

        setUpTitleAndLicenseKeyField()
        setUpBaseUrlField()
        setUpTemplateField()
        setUpNameField()
        setUpDateOfBirthField()
        setUpAddressField()
        setUpPostalCodeField()
        setUpCountryField()
        setUpFlowTableTitleAndLabel()
        setUpNavigationButton()
        contentView.setCustomSpacing(18, after: licenseKeyTextField)
        contentView.setCustomSpacing(18, after: baseUrlTextField)
        contentView.setCustomSpacing(18, after: nameTextField)
        contentView.setCustomSpacing(18, after: addressTextField)
        contentView.setCustomSpacing(18, after: postalCodeTextField)
        contentView.setCustomSpacing(18, after: countryTextField)
    }

    private func setUpTitleAndLicenseKeyField() {
        let titleLabel = FillLabel()
        titleLabel.text = "Test Application"

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(titleLabel)

        let licenseKeyLabel = FillLabel()
        licenseKeyLabel.text = "License key:"

        licenseKeyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(licenseKeyLabel)

        licenseKeyTextField.text = "" // Please provide proper License here
        licenseKeyTextField.backgroundColor = .systemGray6
        licenseKeyTextField.delegate = self

        licenseKeyTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(licenseKeyTextField)
        NSLayoutConstraint.activate([
            licenseKeyTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setUpBaseUrlField() {
        let baseUrlLabel = FillLabel()
        baseUrlLabel.text = "Base url:"

        baseUrlLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(baseUrlLabel)

        baseUrlTextField.text = "https://idv-us.seon.io" // or "https://idv-eu.seon.io" depending on your preference on location
        baseUrlTextField.backgroundColor = .systemGray6
        baseUrlTextField.delegate = self
        baseUrlTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(baseUrlTextField)
        NSLayoutConstraint.activate([
            baseUrlTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setUpTemplateField() {
        let templateIdLabel = FillLabel()
        templateIdLabel.text = "Template Id:"

        templateIdLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(templateIdLabel)

        templateIdTextField.backgroundColor = .systemGray6
        templateIdTextField.delegate = self
        templateIdTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(templateIdTextField)
        NSLayoutConstraint.activate([
            templateIdTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setUpNameField() {
        let nameLabel = FillLabel()
        nameLabel.text = "Name:"

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(nameLabel)
        nameTextField.backgroundColor = .systemGray6
        nameTextField.delegate = self

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setUpDateOfBirthField() {
        let dobLabel = FillLabel()
        dobLabel.text = "Date of Birth:"

        dobLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(dobLabel)

        let dobView = UIView()
        dobView.translatesAutoresizingMaskIntoConstraints = false
        dateOfBirthField.backgroundColor = .systemGray6
        for subview in dateOfBirthField.subviews {
            subview.backgroundColor = .systemGray6
            for deeperSubview in subview.subviews {
                deeperSubview.backgroundColor = .systemGray6
                NSLayoutConstraint.activate([
                    deeperSubview.widthAnchor.constraint(equalTo: dateOfBirthField.widthAnchor),
                ])
            }
        }
        dateOfBirthField.date = Date().addingTimeInterval((-365 * 20) * 86400)
        dateOfBirthField.datePickerMode = .date
        dateOfBirthField.contentHorizontalAlignment = .center
        dateOfBirthField.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        dateOfBirthField.translatesAutoresizingMaskIntoConstraints = false
        dobView.addSubview(dateOfBirthField)

        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("Clear", for: .normal)
        clearButton.titleLabel?.font = .systemFont(ofSize: 14)
        clearButton.setTitleColor(nameTextField.textColor, for: .normal)
        dobView.addSubview(clearButton)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)

        dobMaskView.backgroundColor = .systemGray6
        dobMaskView.translatesAutoresizingMaskIntoConstraints = false
        dobMaskView.isUserInteractionEnabled = false
        dobMaskView.alpha = 0.8
        dobMaskView.isHidden = hasDoB
        dobView.addSubview(dobMaskView)
        NSLayoutConstraint.activate([
            dateOfBirthField.topAnchor.constraint(equalTo: dobView.topAnchor),
            dateOfBirthField.leadingAnchor.constraint(equalTo: dobView.leadingAnchor),
            dateOfBirthField.trailingAnchor.constraint(equalTo: dobView.trailingAnchor),
            dateOfBirthField.heightAnchor.constraint(equalToConstant: 40),
            dobView.heightAnchor.constraint(equalToConstant: 40),
            clearButton.centerYAnchor.constraint(equalTo: dateOfBirthField.centerYAnchor, constant: 0),
            clearButton.trailingAnchor.constraint(equalTo: dateOfBirthField.trailingAnchor, constant: -12),
            dobMaskView.leadingAnchor.constraint(equalTo: dateOfBirthField.leadingAnchor, constant: 0),
            dobMaskView.trailingAnchor.constraint(equalTo: dateOfBirthField.trailingAnchor, constant: 0),
            dobMaskView.topAnchor.constraint(equalTo: dateOfBirthField.topAnchor, constant: 0),
            dobMaskView.bottomAnchor.constraint(equalTo: dateOfBirthField.bottomAnchor, constant: 0)
        ])
        contentView.addArrangedSubview(dobView)
        contentView.setCustomSpacing(18, after: dobView)
    }

    @objc
    private func clearButtonTapped() {
        hasDoB = false
        dateOfBirthField.date = Date().addingTimeInterval((-365 * 20) * 86400)
    }

    @objc
    private func datePickerValueChanged(_ sender: UIDatePicker) {
        hasDoB = true
    }

    private func setUpAddressField() {
        let addressLabel = FillLabel()
        addressLabel.text = "Address:"

        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(addressLabel)

        addressTextField.backgroundColor = .systemGray6
        addressTextField.delegate = self

        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(addressTextField)
        NSLayoutConstraint.activate([
            addressTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setUpPostalCodeField() {
        let zipLabel = FillLabel()
        zipLabel.text = "Postal Code:"

        zipLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(zipLabel)

        postalCodeTextField.backgroundColor = .systemGray6
        postalCodeTextField.delegate = self

        postalCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(postalCodeTextField)
        NSLayoutConstraint.activate([
            postalCodeTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setUpCountryField() {
        let countryLabel = FillLabel()
        countryLabel.text = "ISO Country Code:"
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(countryLabel)

        countryTextField.backgroundColor = .systemGray6
        countryTextField.delegate = self

        countryTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(countryTextField)
        NSLayoutConstraint.activate([
            countryTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setUpFlowTableTitleAndLabel() {
        let flowResultTitleLabel = FillLabel()
        flowResultTitleLabel.text = "Flow result:"

        flowResultTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(flowResultTitleLabel)

        flowResultLabel.text = ""
        flowResultLabel.numberOfLines = 0
        flowResultLabel.textAlignment = .center

        flowResultLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(flowResultLabel)
    }

    private func setUpNavigationButton() {
        let navigateButton = UIButton(type: .system)
        navigateButton.setTitle("Start Verification", for: .normal)
        navigateButton.backgroundColor = .red
        navigateButton.setTitleColor(.white, for: .normal)
        navigateButton.layer.cornerRadius = 16
        navigateButton.addTarget(self, action: #selector(navigateButtonTapped), for: .touchUpInside)

        navigateButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(navigateButton)
        NSLayoutConstraint.activate([
            navigateButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    @objc
    func navigateButtonTapped() {
        guard let navController = navigationController else { return }

        navController.delegate = self
        flowResultLabel.text = ""

        var name: String?
        if let nameText = nameTextField.text, !nameText.isEmpty {
            name = nameText
        }

        var address: String?
        if let addressText = addressTextField.text, !addressText.isEmpty {
            address = addressText
        }
        let dateOfBirth = {
            let date = dateOfBirthField.date
            if hasDoB {
                return DateOfBirth(date: date)
            }
            return nil
        }()

        let customerData = SEONCustomerData(
            licenseKey: licenseKeyTextField.text ?? "",
            referenceId: UUID().uuidString,
            name: name,
            countryISOCode: countryTextField.text,
            address: address,
            postalCode: postalCodeTextField.text,
            dateOfBirth: dateOfBirth
        )

        var templateId: String?
        if let templateIdText = templateIdTextField.text, !templateIdText.isEmpty {
            templateId = templateIdText
        }

        SEONIdVerificationService.shared.initialize(
            baseUrl: baseUrlTextField.text ?? "",
            customerData: customerData,
            templateId: templateId
        )

        SEONIdVerificationService.shared.delegate = self
        SEONIdVerificationService.shared.startIdVerificationFlow(navigationController: navController)
    }
}

extension ViewController: SEONIdVerificationServiceDelegate {
    func didFinishVerificationFlow(result: SEONIdVerification.SEONIdVerificationFlowResult) {
        switch result {
        case .completed:
            flowResultLabel.textColor = .green
            flowResultLabel.text = "Completed"
        case .completedSuccess:
            flowResultLabel.textColor = .green
            flowResultLabel.text = "CompletedSuccess"
        case .completedFailed:
            flowResultLabel.textColor = .green
            flowResultLabel.text = "CompletedFailed"
        case .completedPending:
            flowResultLabel.textColor = .green
            flowResultLabel.text = "CompletedPending"
        case .interruptedByUser:
            flowResultLabel.textColor = .blue
            flowResultLabel.text = "Interrupted by user"
        case .error(let error):
            flowResultLabel.textColor = .red
            flowResultLabel.text = error
        @unknown default:
            flowResultLabel.textColor = .red
            flowResultLabel.text = "Unknown Error"
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

private extension DateOfBirth {
    init? (date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        if let day = components.day, let month = components.month, let year = components.year {
            self.init(day: day, month: month, year: year)
        } else {
            return nil
        }
    }
}

private class FillLabel: UILabel {
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
