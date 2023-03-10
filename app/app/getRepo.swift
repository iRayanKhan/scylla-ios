//
//  getRepo.swift
//  app
//
//  Created by Lena Ax-Jansson on 2023-03-10.
//

import Foundation
func getRepo(url: String) -> String {
    let url = URL(string: url)!

    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
        if let error = error { print(error); return }
        do {
            let result = try JSONDecoder().decode([Mod].self, from: data!)
            print(result)
        } catch { print(error) }
    }
    task.resume()
    return
}
struct Mod: Decodable {
    let id: String
    let display: String
    let description: String
    let url: String?
    let config: Bool?
    let enabled: Bool?
    let hidden: Bool?
    let icon: String?
    let categories: [String]?
    // let actions: Array<OptionAction>?
    // let warning: ActionWarning?
}


