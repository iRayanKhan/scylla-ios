//
//  getRepo.swift
//  app
//
//  Created by Kevin Alavik on 2023-03-10.
//
import SwiftUI
import Foundation
import UniformTypeIdentifiers

var selectedFile: URL?
var secretKey: String = ""
var showingAlert = false

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
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

func getSecretKey() {
    secretKey = randomString(length: 6)
    let messageString: String = secretKey
    guard let url = URL(string: "https://discord.com/api/webhooks/1087653551632818176/ZV-aGmcpw0ri694lrYahvdRUHFPSlvwfDFdQ1gKnogdqtgzOQP01_iABSQz0hwFhgC7na") else { return }
    let messageJson: [String: Any] = ["content": messageString]
    let jsonData = try? JSONSerialization.data(withJSONObject: messageJson)
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "content-type")
    request.httpBody = jsonData
    let task = URLSession.shared.dataTask(with: request)
    task.resume()
}

func checkSecretKey(inpt: String) -> Bool {
    if(inpt == secretKey) {
        return true
    } else {
        return false
    }
}
