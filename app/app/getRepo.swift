//
//  getRepo.swift
//  app
//
//  Created by Kevin Alavik on 2023-03-10.
//

import Foundation

var returnMsg: String = ""

func getRepo(repoUrl: String, completion: @escaping ([String: Any]?) -> Void) {
    let url = URL(string: repoUrl)!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            print("Error: \(error?.localizedDescription ?? "Unknown error")")
            completion(nil)
            return
        }
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                completion(jsonObject)
            } else if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                completion(["data": jsonArray])
            } else {
                completion(nil)
            }
        } catch {
            print("Error parsing JSON: \(error.localizedDescription)")
            completion(nil)
        }
    }
    task.resume()
}
