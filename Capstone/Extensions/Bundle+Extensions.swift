//
//  Bundle+Extensions.swift
//  Capstone
//
//  Created by Nicolle on 26/11/23.
//

import Foundation

extension String {
    static var openAIKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "OpenAI-API-Key", ofType: "plist") else {
                fatalError("Couldn't find file 'OpenAI-API-Key.plist'.")
            }

            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'OpenAI-API-Key.plist'.")
            }

            return value
        }
    }
}
