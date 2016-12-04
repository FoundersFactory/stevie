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
import AVFoundation

class AppController {
    
    static let sharedController = AppController()
    
    func listen(completion:@escaping(_ result: String?, _ didUnderstand: Bool) -> (Void)) {
        
        let speechToText = SpeechToText(username: "34fa8261-6833-44b2-b43d-8120ae84a9af", password: "ek56Y1oTOv2w")
        var settings = RecognitionSettings(contentType: .opus)
        settings.continuous = false
        settings.interimResults = false
        
        // For our demo, we only want to match these words
        settings.keywords = ["card", "chocolate", "keys", "oreo"]
        settings.keywordsThreshold = 0.1
        
        let failure = { (error: Error) in print(error) }
        speechToText.recognizeMicrophone(settings: settings, failure: failure) { results in
            
            print(results.bestTranscript)
            let keyword = results.results.first?.keywordResults?.first?.key

            if keyword != nil {
                completion(keyword!, true)
            } else {
                completion(nil, false)
            }
        }
    }
    
    func detect(item: String, image: UIImage, completion:@escaping (_ confidence: Float) -> (Void)) {
        
        let data = UIImageJPEGRepresentation(image, 0.8)
        Alamofire.upload(data!, to: "http://api.aeye.space:8000/find?class="+item).responseJSON { response in

            let dic = response.result.value as! Dictionary<String, Any>
            completion(dic["score"] as! Float)
        }
    }
    
    func speak(text: String, pitch: Float) {
    
        let utterance = AVSpeechUtterance(string: text)
        utterance.pitchMultiplier = pitch
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
}
