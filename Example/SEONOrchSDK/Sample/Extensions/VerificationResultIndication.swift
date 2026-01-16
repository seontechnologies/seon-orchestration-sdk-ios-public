//
//  VerificationResultIndication.swift
//  SEONOrchSDK-Sample-UIKit
//
//  Created by SEON Technologies Ltd. on 02.09.25.
//  Copyright © 2026 SEON Technologies Ltd. All rights reserved.
//

import SEONOrchSDK
import UIKit

extension SEONOrchSDKFlowResult {
    func getResultIndicationColor() -> UIColor {
        switch self {
        case .completed, .completedSuccess, .completedFailed, .completedPending:
            return .green
        case .interruptedByUser:
            return .blue
        case .error:
            return .red
        @unknown default:
            return .red
        }
    }

    func getResultIndicatorText() -> String {
        switch self {
        case .completed:
            return "Completed"
        case .completedSuccess:
            return "CompletedSuccess"
        case .completedFailed:
            return "CompletedFailed"
        case .completedPending:
            return "CompletedPending"
        case .interruptedByUser:
            return "Interrupted by user"
        case .error(let error):
            return error
        @unknown default:
            return "Unknown Error"
        }
    }
}
