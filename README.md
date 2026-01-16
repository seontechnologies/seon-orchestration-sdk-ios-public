# SEON Orchestration iOS SDK

## Description

SEON Orchestration iOS SDK is a framework designed to streamline the Fraud check and Identity Verification process in your applications. This SDK facilitates integrating SEON's Fraud, Device Fingerprint and ID Verification capabilities into your iOS app seamlessly.

**Owner Team:** SEON Technologies Ltd.

## Installation

SEONOrchSDK is available via Swift Package Manager and Cocoapods. For using Cocoapods, you can simply add it to your Podfile in the required target, like:

```ruby
pod 'SEONOrchSDK', '~> 0.1.0'
```


And this is how you can import SEON Orch SDK into the Xcode project using Switch Package Manager:

##### Xcode (recommended)

- In Xcode, go to **File > Add Packages...**
- Paste the repository URL:

```
https://github.com/seontechnologies/seon-orchestration-sdk-ios-public
```

- Select the **SEONOrchSDK** product and add it to your target.

##### Package.swift

```
dependencies: [
    .package(url: "https://github.com/seontechnologies/seon-orchestration-sdk-ios-public", from: "0.1.0")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "SEONOrchSDK", package: "seon-orchestration-sdk-ios-public")
        ]
    )
]
```

## Quick start

- Import the SDK:

```
import SEONOrchSDK
```

- Initialize the SDK and start the verification flow:

```
SEONOrchSDKService.shared.initialize(
    baseUrl: "https://example.url/", // use the baseUrl you received from SEON
    token: token, // token from your backend after workflow authentication
    language: "en", // optional ISO code
    theme: themeJson // optional JSON string
)

SEONOrchSDKService.shared.delegate = self
SEONOrchSDKService.shared.startWebIdVerificationFlow(navigationController: navigationController)
```

- Implement the delegate to receive flow results:

```
extension YourViewController: SEONOrchSDKServiceDelegate {
    func didFinishVerificationFlow(result: SEONOrchSDK.SEONOrchSDKFlowResult) {
        switch result {
        case .completed, .completedSuccess, .completedPending, .completedFailed:
            // handle completion states
            break
        case .interruptedByUser:
            // user closed the flow
            break
        case .error(let error):
            // show error message
            print(error)
        @unknown default:
            break
        }
    }
}
```

## Permissions (Info.plist)

Add the following keys to your app's `Info.plist`:

```
NSLocationWhenInUseUsageDescription // If you have GeoLocation Data in your Fraud API Check
NSMicrophoneUsageDescription // If you have Camera Checks (ID Verification or Selfie)
NSCameraUsageDescription  // If you have Camera Checks (ID Verification or Selfie)
NSPhotoLibraryUsageDescription // If you have Proof of Address Checks in your Verification
```

## Notes

- For security reasons, the SDK may not work on simulator as expected. Please use real devices.

# Changelog

## 0.1.0
-   Initial Version
