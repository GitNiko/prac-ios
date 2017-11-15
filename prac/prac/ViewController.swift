//
//  ViewController.swift
//  prac
//
//  Created by 凌佳 on 2017/11/9.
//  Copyright © 2017年 凌佳. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
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
    
    override func viewDidAppear(_ animated: Bool) {
//        simpleQueues()
        queuesWithQoS()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case PHAuthorizationStatus.notDetermined:
            print("notDetermined")
        case PHAuthorizationStatus.denied:
            print("denied")
        case PHAuthorizationStatus.authorized:
            print("authorized")
        case PHAuthorizationStatus.restricted:
            print("restricted")
        default:
            print("default")
        }
            
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        let result = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions)
        print(result.count)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

