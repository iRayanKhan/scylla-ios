//
//  RepoSystem.swift
//  app
//
//  Created by Kevin Alavik on 2023-03-13.
//

import Foundation

struct Repo: Decodable {
    let data: [RepoData]
}
struct RepoData: Decodable, Identifiable {
    var id: UUID = UUID()
    let Info: RepoInfo?
    let Utilities: [AppInfo]?
    let Games: [AppInfo]?
    let Tweaks: [AppInfo]?
    let Jailbreaks: [AppInfo]?
    let Programming: [AppInfo]?
    //MARK: SCARLET REPO FORMAT
    let META: RepoInfo?
    let Tweaked: [AppInfo]?
    let Emulators: [AppInfo]?
    let Other: [AppInfo]?
    //MARK: ALTSTORE REPO FROMAT
    let name: String?
    let indentifier: String?
    let sourceURL: String?
    let apps: [AppInfo]?
}


struct AppInfo: Decodable {
    let name: String
    let developer: String?
    let version: String?
    let ipa: URL?
    let icon: URL?
    let iOS: String?
    let color: String?
    //MARK: SCARLET REPO FORMAT
    let down: URL?
    let category: String?
    let banner: String?
    let bundleID: String?
    let description: String?
    let contact: [URL]?
    let screenshots: [URL]?
    let changelog: String?
    let appstore: String?
    let debs: [URL]?
    let dev: String?
    //MARK: ALTSTORE REPO FORMAT
    let versions: [Versions]?
    let versionDate: String?
    let versionDescription: String?
    let downloadURL: URL?
    let localizedDescription: String?
    let iconURL: URL?
    let tintColor: String?
    let size: Int?
    let screenshotURLs: [URL]?
    let permissions: [Permissions]?
    let bundleIdentifier: String?
    let developerName: String?
}
struct RepoInfo: Decodable, Hashable {
    let repoName: String?
    let repoAuthor: String?
    let repoVersion:  String?
    let repoDescription: String?
    //MARK: SCARLET REPO FORMAT
    let repoIcon: URL?
}

struct Versions: Decodable, Hashable {
    let version: String?
    let date: String?
    let localizedDescription: String?
    let downloadURL: URL?
    let size: Int?
}

struct Permissions: Decodable, Hashable {
    let type: String?
    let usageDescription: String?
}

/* class RepoModel: ObservableObject {  @Published var items = [RepoData]();
    func fetchData(repoUrl: String) {
        guard let url = URL(string: repoUrl) else { return };
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          do {
             if let data = data {
                 let result = try JSONDecoder().decode([RepoData].self, from: data);
                 DispatchQueue.main.async {
                     self.items = result
                 }
                 print(result)
             } else {
                 print("No data")
             }
          } catch (let error) {
             print(error.localizedDescription)
          }
         }.resume()
    }
    func newFetchData(repoUrl: String) {
        guard let url = URL(string: repoUrl) else { return };
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    if let result = try? JSONDecoder().decode([RepoData].self, from: data) {
                        print(result)
                        DispatchQueue.main.async {
                            self.items = result
                        }
                    } else {
                        print("Invalid Response")
                    }
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
    

} */

func fetchRepoData(repoUrl: String, completion: @escaping (Result<Repo, Error>) -> Void) {
    guard let url = URL(string: repoUrl) else {
        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        return
    }

    let session = URLSession.shared
    let task = session.dataTask(with: url) { (data, response, error) in
        guard let data = data, error == nil else {
            completion(.failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
            return
        }

        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Repo.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }

    task.resume()
}
