# PapilonIDRecognitioniOS

[![pod - 1.0.0](https://img.shields.io/badge/pod-1.0.0-blue)](https://cocoapods.org/)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 13+

## Installation

PapilonIDRecognitioniOS is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PapilonIDRecognitioniOS', '1.0.0'
```
## Setup PapilonIDRecognitioniOS
You will need to have a licence token to run this SDK. Please contact [Papilon Savunma](https://papilon.com.tr/tr/) or send an e-mail to yasinkoker@papilon.com.tr

## Usage

Simply create an object with class `IDRecognizer`, with initializers `idType`, `token` and `licenceID`. The "token" and "licenceID" will be given from Papilon Savunma.


**IMPORTANT:** *The token you take belongs only to you and you must not lose it. If there is a problem with the token or package contact Papilon Savunma with `licenceID` that is given to you.*

This package has ID Recognition features for several countries' ID cards, passports and driving liciences.
Here are the options for ID recognitions:


| Parameter | Type     | Value |         Description |
| :-------- | :------- | :---- | :------------------------- |
| `idType` | `string` | `586_nic_id_front`   | PK NIC ID Front |
| `idType` | `string` | `586_nicop_id_front`   | PK NICOP ID Front |


```swift
func captureOutput(
  _ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer,
  from connection: AVCaptureConnection
) {
  // Ensure we can retrieve an image from the provided sample buffer.
  guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
    debugPrint("Unable to get image from sample buffer")
    return
  }

  // If the idRecognizer instance has not been created yet (i.e., it's nil),
  // we initialize it. This will only run once due to the nature of optional values.
  if idRecognizer == nil {
    idRecognizer = IDRecognizer(
      idType: "###ID_TYPE###",
      token: "###TOKEN_TAKEN_FROM_PAPILON###",
      licenceID: "###LICENCE_ID_TAKEN_FROM_PAPILON###"
    ) {
      // This closure is called after the IDRecognizer initialization.
      // Add any additional setup or tasks you wish to perform once after
      // IDRecognizer is initialized.
    }
  }

  // Using the initialized idRecognizer instance, we call the detectIDDocument function.
  if let results = idRecognizer?.detectIDDocument(in: frame) {
    print("======== RESULTS ========")
    for (key, value) in results {
      print("\(key): \(value)")
    }
    print("======== RESULTS ========")
  }
}
```

## License

See the LICENSE file for more info.
