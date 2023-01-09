//
//  DictionaryViewModel.swift
//  MyDictionary
//
//  Created by Monica Deshwal on 07/01/23.
//

import Foundation
import Combine
import SwiftUI

enum FetchError: Error {
    case unableToRetriveData
}

class DictionaryViewModel: ObservableObject {
    
    var modelObject: [DictWord]?
    @Published var dictWordSubject: DictWord?
    
    init() {
        let url = Bundle.main.url(forResource: "DictionaryObject", withExtension: "json")!
        do {
            let data = try? Data(contentsOf: url)
            let model = try? JSONDecoder().decode(MyDictModel.self, from: data!)
            let modelObject = model?.words?.compactMap({ $0 })
            self.modelObject = modelObject
            updateTheObserver()
        } catch let error {
            print("there is some error \(error)")
        }
    }
    
    func updateTheObserver() {
        dictWordSubject = self.generateTherandomElement()
    }
    
    
    private func generateTherandomElement() -> DictWord? {
        return self.modelObject?.randomElement()
    }
}

struct MyDictModel : Codable {
    let words : [DictWord]?

    enum CodingKeys: String, CodingKey {

        case words = "Words"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        words = try values.decodeIfPresent([DictWord].self, forKey: .words)
    }

}


struct DictWord : Codable {
    let word : String?
    let usageType : String?
    let meaning: String?
    let sentense : String?

    enum CodingKeys: String, CodingKey {

        case word = "Word"
        case usageType = "UsageType"
        case meaning = "Meaning"
        case sentense = "Sentense"
    }
    
    init(word: String? = ""
         , usageType : String? = ""
         , meaning: String? = ""
         , sentense : String? = "") {
        self.word = word
        self.usageType = usageType
        self.meaning = meaning
        self.sentense = sentense
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        word = try values.decodeIfPresent(String.self, forKey: .word)
        usageType = try values.decodeIfPresent(String.self, forKey: .usageType)
        meaning = try values.decodeIfPresent(String.self, forKey: .meaning)
        sentense = try values.decodeIfPresent(String.self, forKey: .sentense)
    }

}


//struct MyDictModel: Codable {
//    let wordModel: WordModel
//}
//
//struct WordModel: Codable {
//    let word: String?
//    let usageType: String?
//  //  let meaning: String?
//    let sentense:String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case word = "Word"
//        case usageType = "UsageType"
//        //case meaning = "Meaning"
//        case sentense = "Sentense"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        word = try values.decodeIfPresent(String.self, forKey: .word)
//      //  meaning = try values.decodeIfPresent(String.self, forKey: .meaning)
//        usageType = try values.decodeIfPresent(String.self, forKey: .usageType)
//        sentense = try values.decodeIfPresent(String.self, forKey: .sentense)
//    }
//}
