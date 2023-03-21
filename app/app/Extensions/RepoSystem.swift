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
    let Emulators: [AppInfo]
    let Other: [AppInfo]
    //MARK: ALTSTORE REPO FROMAT
    let name: String
    let indentifier: String
    let sourceURL: String
    let apps: [AppInfo]
}


struct RepoInfo: Decodable {
    let repoName: String
    let repoAuthor: String
    let repoVersion:  String
    let repoDescription: String
    //MARK: SCARLET REPO FORMAT
    let repoIcon: String
}

struct AppInfo: Decodable {
    let name: String
    let developer: String
    let version: String
    let ipa: String
    let icon: String
    let iOS: String
    let color: String
    //MARK: SCARLET REPO FORMAT
    let down: String
    let category: String
    let banner: String
    let bundleID: String
    let description: String
    let contact: [String]
    let screenshots: [String]
    let changelog: String
    let appstore: String
    let debs: [String]
    let dev: String
    //MARK: ALTSTORE REPO FORMAT
    let versions: [Versions]
    let versionDate: String
    let versionDescription: String
    let downloadURL: String
    let localizedDescription: String
    let iconURL: String
    let tintColor: String
    let size: Int
    let screenshotURLs: [String]
    let permissions: [Permissions]
    let bundleIdentifier: String
    let developerName: String
}

struct Versions: Decodable {
    let version: String
    let date: String
    let localizedDescription: String
    let downloadURL: String
    let size: Int
}

struct Permissions: Decodable {
    let type: String
    let usageDescription: String
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
