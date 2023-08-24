//
//  ViewController.swift
//  IDRecognitionDemo
//
//  Created by Yasin on 24.08.2023.
//

import UIKit
import AVFoundation
import PapilonIDRecognitioniOS

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var idRecognizer: IDRecognizer?
    
    func showCapturedImages() {
        let capturedImagesVC = CapturedImagesViewController(images: idRecognizer?.getCapturedImages() ?? [])
        self.present(capturedImagesVC, animated: true, completion: nil)
    }
 
    private var scanningIsEnabled = true {
        didSet {
            scanningIsEnabled ? captureSession.startRunning() : captureSession.stopRunning()
        }
    }
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var capturedImageView: UIImageView!
    @IBOutlet weak var takePhotoBtn: UIButton!
    
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    private let videoDataOutput = AVCaptureVideoDataOutput()
    
    private var maskLayer = CAShapeLayer()
    
    private var isTapped = false
    
    override func viewDidAppear(_ animated: Bool) {
        //session Start
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        self.captureSession.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //session Stopped
        self.videoDataOutput.setSampleBufferDelegate(nil, queue: nil)
        self.captureSession.stopRunning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCameraInput()
        self.showCameraFeed()
        self.setCameraOutput()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewLayer.frame = self.previewView.bounds

    }
    
    //MARK: Session initialisation and video output
    private func setCameraInput() {
        guard let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera, .builtInDualCamera, .builtInTrueDepthCamera],
            mediaType: .video,
            position: .back).devices.first else {
                fatalError("No back camera device found.")
            }
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        self.captureSession.addInput(cameraInput)
    }
    
    private func showCameraFeed() {
        self.previewLayer.videoGravity = .resizeAspectFill
        self.previewView.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.previewView.frame
    }
    
    private func setCameraOutput() {
        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        self.captureSession.addOutput(self.videoDataOutput)
        
        guard let connection = self.videoDataOutput.connection(with: AVMediaType.video),
              connection.isVideoOrientationSupported else { return }
        
        connection.videoOrientation = .portrait
    }
    
    //MARK: AVCaptureVideo Delegate
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Ensure we can retrieve an image from the provided sample buffer.
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("Unable to get image from sample buffer")
            return
        }

        // If the idRecognizer instance has not been created yet (i.e., it's nil),
        // we initialize it. This will only run once due to the nature of optional values.
        if idRecognizer == nil {
            idRecognizer = IDRecognizer(
                idType: "792_id_back",
                token: "2704403df415899bf379e18bd00d015a5cc6f561c34f2687a04c22499734cc9cb1474a9e16a20aa9e7af2807cfb120b49725",
                licenceID: "7") {
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

        
        // set the captured marker image to the UIImageView
        DispatchQueue.main.async {
            if let marker = self.idRecognizer {
                self.capturedImageView.image = marker.IDUIImage
            }
        }
    }


    func removeMask() {
        maskLayer.removeFromSuperlayer()
    }
    
    //MARK: Handle photo Button
    @IBAction func didTakePhoto(_ sender: UIButton) {
        self.isTapped = true
        
        print("button clicked!")
        
        let capturedImagesVC = CapturedImagesViewController(images: [])
        self.navigationController?.pushViewController(capturedImagesVC, animated: true)
        
        showCapturedImages()
    }
}
