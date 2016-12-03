//
//  AppController.swift
//  Stevie
//
//  Created by Phillip Caudell on 03/12/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

import UIKit
import SpeechToTextV1
import Alamofire

class AppController {
    
    static let sharedController = AppController()
    
    init() {
    
    }
    
    func startListening() {
        
        let speechToText = SpeechToText(username: "34fa8261-6833-44b2-b43d-8120ae84a9af", password: "ek56Y1oTOv2w")
        var settings = RecognitionSettings(contentType: .opus)
        settings.continuous = false
        settings.interimResults = false
        
        let failure = { (error: Error) in print(error) }
        speechToText.recognizeMicrophone(settings: settings, failure: failure) { results in
            print(results.bestTranscript)
        }
    }
    
    func detect(item: String, image: UIImage, completion:@escaping (_ confidence: Float) -> (Void)) {
        
        let data = UIImageJPEGRepresentation(image, 0.8)
        Alamofire.upload(data!, to: "http://ec2-52-50-132-122.eu-west-1.compute.amazonaws.com:8000/find?class=card").responseJSON { response in

            let dic = response.result.value as! Dictionary<String, Any>
            completion(dic["score"] as! Float)
        
        }
        
    }
}
