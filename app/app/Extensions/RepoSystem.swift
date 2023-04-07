//
//  RepoSystem.swift
//  app
//
//  Created by Kevin Alavik on 2023-03-13.
//

import Foundation

struct Repo: Decodable, Identifiable {
    let id: UUID = UUID()
    var repo: String?
    var error: String?
    //MARK: SCYLLA REPO FORMAT
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
    let ipa: String?
    let icon: String?
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
struct RepoInfo: Decodable {
    let repoName: String?
    let repoAuthor: String?
    let repoVersion:  String?
    let repoDescription: String?
    let repoIcon: String?
}

struct Versions: Decodable {
    let version: String?
    let date: String?
    let localizedDescription: String?
    let downloadURL: URL?
    let size: Int?
}

struct Permissions: Decodable {
    let type: String?
    let usageDescription: String?
}

func fetchRepoData(repoUrl: String, completion: @escaping (Result<Repo, Error>) -> Void) {
    guard let url = URL(string: repoUrl) else {
        completion(.failure(NSError(domain: repoUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data, error == nil else {
            completion(.failure(error ?? NSError(domain: repoUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
            return
        }

        do {
            let decodedData = try JSONDecoder().decode(Repo.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }

    task.resume()
}
