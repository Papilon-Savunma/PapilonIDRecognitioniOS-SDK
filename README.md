# PapilonIDRecognitioniOS

[![pod - 1.0.6](https://img.shields.io/badge/pod-1.0.3-blue)](https://cocoapods.org/)

PapilonIDRecognitioniOS-SDK is a robust SDK that offers ID recognition features for various countries' ID cards, passports, and driving licenses.

## Getting Started

To run the example project, clone the repo, and run `pod install` in the IDRecognitionDemo directory first.

### Prerequisites

- iOS 13+

### Installation

This SDK is available through CocoaPods. Add the following line to your Podfile:

```ruby
pod 'PapilonIDRecognitioniOS-SDK'
```

Then, run the following command:

```ruby
pod install
```

## Setup PapilonIDRecognitioniOS-SDK

For the SDK to function, you require a license token. Reach out to Papilon Savunma or drop an email at yasinkoker@papilon.com.tr for the same.

Note: Ensure the safekeeping of your token as it's unique to you. In case of any discrepancies, contact Papilon Savunma with the provided licenceID.

## Usage

#### 1. Podfile Configuration

Ensure your Podfile resembles the following:

```ruby
use_frameworks!

platform :ios, '13.0'

target 'IDRecognitionDemo' do
  pod 'PapilonIDRecognitioniOS-SDK'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
```

#### 2. Camera Permission

Ensure that your application has permission to access the camera. Update your info.plist accordingly.

#### 3. SDK Initialization

Simply create an object with class `IDRecognizer`, with initializers `idType`, `token` and `licenceID`. The "token" and "licenceID" will be given from Papilon Savunma.

```swift
// Sample Initialization
let idRecognizer = IDRecognizer(
  idType: "###ID_TYPE###",
  token: "###TOKEN_TAKEN_FROM_PAPILON###",
  licenceID: "###LICENCE_ID_TAKEN_FROM_PAPILON###"
)
```

For more detailed usage, examine the sample application.

#### Supported ID Types

- list will be updated.

| Parameter | Type     | Value                | Description       |
| :-------- | :------- | :------------------- | :---------------- |
| `idType`  | `string` | `586_nic_id_front`   | PK NIC ID Front   |
| `idType`  | `string` | `586_nicop_id_front` | PK NICOP ID Front |
