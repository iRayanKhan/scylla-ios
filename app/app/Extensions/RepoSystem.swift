//
//  RepoSystem.swift
//  app
//
//  Created by Kevin Alavik on 2023-03-13.
//

import Foundation

struct RepoData: Decodable {
    let Info: [RepoInfo]
    let Utilities: [AppInfo]
    let Games: [AppInfo]
    let Tweaks: [AppInfo]
    let Jailbreaks: [AppInfo]
    let Programming: [AppInfo]
    //MARK: SCARLET REPO FORMAT 
    let META: [RepoInfo]
    let Tweaked: [AppInfo]
}


struct RepoInfo: Decodable {
    let repoName: String
    let repoAuthor: String
    let repoVersion: Int
    //MARK: SCARLET REPO FORMAT
    let repoIcon: String
}

struct AppInfo: Decodable {
    let name: String
    let developer: String
    let version: Int
    let ipa: String
    let icon: String
    let iOS: String
    //MARK: SCARLET REPO FORMAT
    let down: String
    let category: String
    let banner: String
    let bundleID: String
    let description: String
    let contact: [ContactInfo]
    let screenshots: [String]
}

struct ContactInfo: Decodable {
    let web: String   
    let twitter: String
}

class RepoModel: ObservableObject {  @Published var items = [RepoData]();
    func fetchData(repoUrl: String) {
        guard let url = URL(string: repoUrl) else { return };    URLSession.shared.dataTask(with: url) { (data, response, error) in
          do {
             if let data = data {
                 let result = try JSONDecoder().decode([RepoData].self, from: data);
                 DispatchQueue.main.async {
                     self.items = result
                 }
             } else {
                 print("No data")
             }
          } catch (let error) {
             print(error.localizedDescription)
          }
         }.resume()
  }
}
