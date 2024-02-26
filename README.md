# PapilonIDRecognitioniOS

[![pod - 1.1.5](https://img.shields.io/badge/pod-1.1.5-blue)](https://cocoapods.org/)

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

First, import PapilonIDRecognitioniOS in your ViewController:
```swift
import UIKit
import AVFoundation
import PapilonIDRecognitioniOS
```

Then, initialize and configure the CameraManager:
```swift
class ViewController: UIViewController, CameraManagerDelegate {
    var cameraManager: CameraManager?
    
    @IBOutlet weak var previewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraManager = CameraManager()
        cameraManager?.delegateCameraManager = self
        cameraManager?.configureCameraManager(
          idType: "<id_type>", 
          token: "<your_token>", 
          licenseID: "<license_id>", 
          in: previewView)
    }
}
```

Implement CameraManagerDelegate methods to handle captured images, distance evaluation, and ID document detection:
```swift
extension ViewController {
    
    func didCaptureImages(_ images: [IDRecognizer.ImageResult]) {
        // Handle captured images
    }
    
    func didEvaluateDistance(evaluation: IDRecognizer.DistanceEvaluation) {
        // Handle distance evaluation
    }
    
    func didDetectIDDocument(results: [String : Any]) {
        // Handle ID document detection
    }
    
    func didUpdateMarkerImage(_ image: UIImage) {
        // Handle marker image updates
    }
}
```

For more detailed usage, examine the sample application.

#### Supported ID Types

- list will be updated.

| Parameter | Type     | Value                | Description       |
| :-------- | :------- | :------------------- | :---------------- |
| `idType`  | `string` | `586_nic_id_front`   | PK NIC ID Front   |
| `idType`  | `string` | `586_nicop_id_front` | PK NICOP ID Front |
