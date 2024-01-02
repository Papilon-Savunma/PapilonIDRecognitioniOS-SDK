Pod::Spec.new do |s|
  s.name             = 'PapilonIDRecognitioniOS-SDK'
  s.version          = '1.0.7'
  s.summary          = 'ID and Passport Recognition with OCR'

  s.description      = "Library for ID Recognition and OCR on several countries' ID cards"

  s.platform         = :ios
  s.homepage         = 'https://github.com/Papilon-Savunma/PapilonIDRecognitioniOS-SDK'
  s.license          = { :type => 'Papilon Savunma', :file => 'LICENSE' }
  s.author           = { 'yasinkoker' => 'yasinkoker@papilon.com.tr' }
  s.source = { :git => 'https://github.com/Papilon-Savunma/PapilonIDRecognitioniOS-SDK.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  s.vendored_frameworks = 'PapilonIDRecognitioniOS.xcframework'
end
