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
import SEONResolver

/// Mirrors the region selector in the Flutter sample app
/// (seon-orchestration-sdk-flutter-public/lib/main.dart `SeonRegion` + `kBaseUrls`).
enum Region: Int, CaseIterable {
    case eu
    case us
    case apac

    var displayName: String {
        switch self {
        case .eu:   return "EU"
        case .us:   return "US"
        case .apac: return "APAC"
        }
    }

    var baseUrl: String {
        switch self {
        case .eu:   return "https://api.seon.io/orchestration-api"
        case .us:   return "https://api.us-east-1-main.seon.io/orchestration-api"
        case .apac: return "https://api.ap-southeast-1-main.seon.io/orchestration-api"
        }
    }

    static var `default`: Region { .eu }
}

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
        region: Region,
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
            region: region,
            language: language,
            theme: theme,
            navigationController: navigationController,
            delegate: delegate
        )
    }

    private func initializeSDKWithToken(
        _ token: String,
        region: Region,
        language: String?,
        theme: String?,
        navigationController: UINavigationController,
        delegate: SEONOrchSDKServiceDelegate?
    ) {
        // The SDK handles token parsing and client-init internally; we just have
        // to give it the correct regional orchestration host.
        // Environment    URL
        // EU             https://api.seon.io/orchestration-api
        // US             https://api.us-east-1-main.seon.io/orchestration-api
        // APAC           https://api.ap-southeast-1-main.seon.io/orchestration-api
        SEONOrchSDKService.shared.initialize(
            baseUrl: region.baseUrl,
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
