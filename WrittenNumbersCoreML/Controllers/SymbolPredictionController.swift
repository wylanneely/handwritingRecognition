//
//  File.swift
//  WrittenNumbersCoreML
//
//  Created by Wylan L Neely on 4/13/20.
//  Copyright © 2020 Wylan L Neely. All rights reserved.
//

import Foundation
import Vision
import CoreML
import UIKit

class NumberPredictorController {
    
    
    var visionModel: VNCoreMLModel?
    var predictionRequests = [VNRequest]()
    
    fileprivate var currentPredictions:[VNClassificationObservation] = []
    fileprivate var predictionSessionUUID: UUID
    fileprivate var predictions = [String: SymbolPrediction]()
    var highestConfidenceSymbol: String? {
        return  currentPredictions.sorted(by: { $0.confidence > $1.confidence }).map({$0.identifier}).first
    }
    
    init(){
        predictionSessionUUID = UUID()
        guard let model = try? VNCoreMLModel(for: WrittenNumbersClassifier_7().model) else {
            self.visionModel = nil
            fatalError("Machine Learning Model: FAILED TO LOAD")
               }
               self.visionModel = model
        loadPredictionRequests()
        var zeroPrediction: SymbolPrediction = SymbolPrediction(symbol: "0")
        var onePrediction: SymbolPrediction = SymbolPrediction(symbol: "1")
        var twoPrediction: SymbolPrediction = SymbolPrediction(symbol: "2")
        var threePrediction: SymbolPrediction = SymbolPrediction(symbol: "3")
        var fourPrediction: SymbolPrediction = SymbolPrediction(symbol: "4")
        var fivePrediction: SymbolPrediction = SymbolPrediction(symbol: "5")
        var sixPrediction: SymbolPrediction = SymbolPrediction(symbol: "6")
        var sevenPrediction: SymbolPrediction = SymbolPrediction(symbol: "7")
        var eightPrediction: SymbolPrediction = SymbolPrediction(symbol: "8")
        var ninePrediction: SymbolPrediction = SymbolPrediction(symbol: "9")
        self.predictions =  ["0":zeroPrediction,
                        "1":onePrediction,"2":twoPrediction,"3":threePrediction,
                        "4":fourPrediction,"5":fivePrediction,"6":sixPrediction,
                        "7":sevenPrediction,"8":eightPrediction,"9":ninePrediction]
    }
    
    
    
    
    var zeroPrediction: SymbolPrediction? {
        return predictions["0"]
    }
    var onePrediction: SymbolPrediction? {
        return predictions["1"]
    }
    var twoPrediction: SymbolPrediction? {
        return predictions["2"]
    }
    var threePrediction: SymbolPrediction? {
        return predictions["3"]
    }
    var fourPrediction: SymbolPrediction? {
        return predictions["4"]
    }
    var fivePrediction: SymbolPrediction? {
        return predictions["5"]
    }
    var sixPrediction: SymbolPrediction? {
        return predictions["6"]
    }
    var sevenPrediction: SymbolPrediction? {
        return predictions["7"]
    }
    var eightPrediction: SymbolPrediction? {
        return predictions["8"]
    }
    var ninePrediction: SymbolPrediction? {
        return predictions["9"]
    }

    public subscript(_ symbol: String) -> SymbolPrediction? {
            get { return predictions[symbol] }
            set { predictions[symbol] = newValue }
        }
    
    private func loadPredictionRequests(){
        let requests = VNCoreMLRequest(model: visionModel!, completionHandler: predictionRequestHandler)
        predictionRequests = [requests]
    }
    
    
    func requestPrediction(with image: UIImage, completion: (_ success:Bool) -> Void) {
        let imageRequestHandler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])

        do {
            try imageRequestHandler.perform(predictionRequests)
            completion(true)
        } catch {
            completion(false)
            print(error)
        }
    }

   fileprivate func predictionRequestHandler(request:VNRequest, error: Error?) {
        guard let observations = request.results else {
            print("No results") ; return }
        let classifications = observations
            .compactMap({$0 as? VNClassificationObservation})
        extractPredictions(from: classifications)
    self.currentPredictions = classifications
    }
    
    
    fileprivate func extractPredictions(from classificationObservations: [VNClassificationObservation]) {
        let sessionUUID = UUID()
        for observation in classificationObservations {
                let id = observation.identifier
            let confidence =  observation.confidence
            updateSymbolPrediction(symbol: id, confidence: confidence, uuid: sessionUUID)
        }
            }
    
   fileprivate func updateSymbolPrediction(symbol: String, confidence:VNConfidence, uuid: UUID) {
      let updatedPrediction = SymbolPrediction(confidence: confidence, uuid: uuid, symbol: symbol)
        predictions[symbol] = updatedPrediction
    }
    
    fileprivate func updateSortClassifications(observations: [VNClassificationObservation]) {
        self.currentPredictions = observations.sorted(by: {$0.confidence > $1.confidence})
    }
    
    
    

}
