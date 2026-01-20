//
//  ViewModel.swift
//  SEONOrchSDKSample
//
//  Created by SEON Technologies Ltd. on 02.09.25.
//  Copyright © 2026 SEON Technologies Ltd. All rights reserved.
//

import Foundation
import SEONOrchSDK
import UIKit
import Resolver

class MainViewModel {

    private var defaultLanguage: String { "en" }

    // MARK: - Theme JSON
    func getDefaultThemeJSON() -> String {
        return """
{
    "light":{
        "baseTextOnLight":"#000000",
        "baseTextOnDark":"#FFFFFF",
        "baseAccent":"#0063FF",
        "baseOnAccent":"#FFFFFF"
    },
    "dark":{
        "baseTextOnLight":"#FFFFFF",
        "baseTextOnDark":"#000000",
        "baseAccent":"#4185F2",
        "baseOnAccent":"#000000"
    },
    "fontFamily":"idverif-default",
    "fontUrl":"./fonts/Inter-VariableFont_slnt.ttf",
    "fontWeight":"400"
}
"""
    }

    // MARK: - SDK Initialization
    // swiftlint:disable:next function_parameter_count
    func initializeSDK(
        sessionToken: String?,
        language: String?,
        theme: String?,
        navigationController: UINavigationController,
        delegate: SEONOrchSDKServiceDelegate? = nil
    ) {
        // Session Token mode - use JWT token
        guard let sessionToken = sessionToken, !sessionToken.isEmpty else {
            // You need the sessionToken anyway. You can handle the error accordingly
            return
        }

        // Initialize SDK with the provided session token
        initializeSDKWithToken(
            sessionToken,
            language: language,
            theme: theme,
            navigationController: navigationController,
            delegate: delegate
        )
    }

    private func initializeSDKWithToken(
        _ token: String,
        language: String?,
        theme: String?,
        navigationController: UINavigationController,
        delegate: SEONOrchSDKServiceDelegate?
    ) {
        // The SDK now handles token parsing, region fetching, and client-init internally
        // you may specify your baseUrl based on the region:
        // Environment    URL
        // EU             https://api.seon.io/orchestration-api
        // US             https://api.us-east-1-main.seon.io/orchestration-api
        // APAC           https://api.ap-southeast-1-main.seon.io/orchestration-api
        
        SEONOrchSDKService.shared.initialize(
            baseUrl: "https://api.seon.io/orchestration-api",
            token: token,
            language: language,
            theme: theme
        )

        if let delegate = delegate {
            SEONOrchSDKService.shared.delegate = delegate
        }
        SEONOrchSDKService.shared.startWebIdVerificationFlow(navigationController: navigationController)
    }
}

// MARK: - Error Types
enum SDKInitializationError: LocalizedError {
    case missingSessionToken

    var errorDescription: String? {
        switch self {
        case .missingSessionToken:
            return "Please enter a valid JWT session token."
        }
    }
}
