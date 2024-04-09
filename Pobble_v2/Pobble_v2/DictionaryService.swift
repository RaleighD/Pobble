//
//  DictionaryService.swift
//  Pobble_v2
//
//  Created by Raleigh Desmond on 2024-03-21.
//

import Foundation

class DictionaryService {
    
    func validateWord(word: String, completion: @escaping (Bool) -> Void) {
        let urlString = "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error during URLSession data task: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
                return
            }
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                    
                    // Checking if the first object is a dictionary and has the "word" key
                    if let firstItem = jsonResult.first as? [String: Any], firstItem["word"] != nil {
                        completion(true) // Valid word
                        return
                    } else if let firstItem = jsonResult.first as? [String: Any], firstItem["title"] != nil {
                        completion(false) // Invalid word
                        return
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
            completion(false)
        }.resume()
    }
}
