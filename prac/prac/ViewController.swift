//
//  ViewController.swift
//  prac
//
//  Created by 凌佳 on 2017/11/9.
//  Copyright © 2017年 凌佳. All rights reserved.
//

import UIKit
import Photos
import ImagePicker

class ViewController: UIViewController, ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        //
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        //
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        //
    }
    
    
    @IBOutlet weak var imageview: UIImageView!
    func simpleQueues() {

        let queue = DispatchQueue(label: "com.niko.myqueue")
        queue.async {
            for i in 0..<10 {
                print("❌ ", i)
            }
        }

        for i in 100..<110 {
            print("🐱 ", i)
        }
        
    }
    
    func queuesWithQoS() {
        let queue1 = DispatchQueue(label: "com.niko.queue1", qos: DispatchQoS.background)
        let queue2 = DispatchQueue(label: "com.niko.queue2", qos: DispatchQoS.utility)
        
        queue1.async {
            for i in 0..<10 {
                print("🌈", i)
            }
        }
        queue2.async {
            for i in 100..<110 {
                print("🌞", i)
            }
        }
    }
    var inactiveQueue: DispatchQueue!
    func concurrentQueues() {
//        let anotherQueue = DispatchQueue(label: "com.niko.anotherQueue", qos: .utility, attributes: .concurrent)
        let anotherQueue = DispatchQueue(label: "com.niko.anotherQueue", qos: .utility, attributes: [.initiallyInactive, .concurrent])
        
        inactiveQueue = anotherQueue
        
        anotherQueue.async {
            for i in 0..<10 {
                print("🌞", i)
            }
        }
        
        anotherQueue.async {
            for i in 100..<110 {
                print("🌛", i)
            }
        }
        
        anotherQueue.async {
            for i in 1000..<1010 {
                print("🌍", i)
            }
        }
    }
    
    func queueWithDelay(){
        let delayQueue = DispatchQueue(label: "com.niko.delayqueue", qos: .userInitiated)
        print(Date())
        let additionalTime: DispatchTimeInterval = .seconds(2)
        
        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
            print(Date())
        }
    }
    
    func fetchImage() {
        let imageURL: URL = URL(string: "https://www.appcoda.com/wp-content/uploads/2015/12/blog-logo-dark-400.png")!
        
        (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler:{ (imageData, response, error) in
            if let data = imageData {
                print("did download image data")
                DispatchQueue.main.async {
                    self.imageview.image = UIImage(data: data)
                }
            }
        }).resume()
    }
    
    func useWorkItem() {
        var value = 10
        
        let workItem = DispatchWorkItem {
            value += 5
        }
        
        workItem.perform()
        
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async(execute: workItem)
        
        workItem.notify(queue: DispatchQueue.main) {
            print("value = ", value)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
//        simpleQueues()
//        queuesWithQoS()
//        concurrentQueues()
//        if let queue = inactiveQueue {
//            queue.activate()
//        }
//        queueWithDelay()
//        fetchImage()
//        useWorkItem()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
//        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
//
//
//        PHPhotoLibrary.requestAuthorization({
//            (status: PHAuthorizationStatus) in
//            switch status {
//            case PHAuthorizationStatus.notDetermined:
//                print("notDetermined")
//            case PHAuthorizationStatus.denied:
//                print("denied")
//            case PHAuthorizationStatus.authorized:
//                print("authorized")
//                let allPhotosOptions = PHFetchOptions()
//                allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
//                let result = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions)
//                print(result.count)
//                let asset = result[0]
////                asset.
//            case PHAuthorizationStatus.restricted:
//                print("restricted")
//            default:
//                print("default")
//            }
//    })
        
        
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
//        self.present(imagePickerController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

