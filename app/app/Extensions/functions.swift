//
//  getRepo.swift
//  app
//
//  Created by Kevin Alavik on 2023-03-10.
//
import SwiftUI
import Foundation
import UniformTypeIdentifiers

var returnMsg: String = ""
var selectedFile: URL?
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

func openDocumentPicker(fileExtension: String, allowMultiple: Bool) {
    let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType(filenameExtension: fileExtension)!])
    documentPicker.modalPresentationStyle = .overFullScreen
    documentPicker.allowsMultipleSelection = allowMultiple // set the property on documentPicker
    
    // Present the document picker
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        // Use the windowScene instance here
        let windows = windowScene.windows
        windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
    } else {
        return
    }
}
