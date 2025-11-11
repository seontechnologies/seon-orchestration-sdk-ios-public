# SEONIDV Example Application

## Description

This is a Example App to show you how to integrate SEON ID Verification iOS SDK into your app.

**Owner Team:** SEON Technologies Ltd.

## Installation

**I. Bundle Identifier**

Please notice that you need to have a LicenseKey, associated with the Bundle Identifier of your iOS Application registered in our Portal, to allow you to use the SDK on your app. So, the first step of using this example app is to modify the Bundle Identifier in the Project and set it to your own registered Bundle Identifier.

**II. Installing Cocoapods**

Next, is to run the command

```
pod install
```

in your terminal, in the root folder of this example. This will install IDV SDK along with its dependencies to make it work.

**III. Specifying your Team**

Since the app is supposed to get installed on a Real Device for testing the SDK, you need to specify your Team in Xcode.
You need to:
 1. Tap on the Project Name `SEONIDV` in the Project Navigator.
 2. Under the Targets Section, select `SEONIDV`.
 3. Select the Tab `Signing & Capabilities`.
 4. Select a Team which is your Apple Team Name. If you don't see your Apple Team Name there, you need to tap on the `Add an Account` from that dropdown list and add your Apple ID in Xcode Settings. Once you do this, your Team Name should be selectable there.
 5. Run the app.

**IV. Setting LicenseKey**

You need to use your own LicenseKey to use the SDK. For adding the LicenseKey, there are two ways:

 1. To simply type the LicenseKey in the initial Screen when the app runs on your device.
 2. To specify the LicenseKey in the ViewController of this example app, in this line:
 
 ```swift
    licenseKeyTextField.text = "" // Please provide proper LicenseKey here
```
