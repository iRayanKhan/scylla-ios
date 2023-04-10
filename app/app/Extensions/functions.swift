//
//  getRepo.swift
//  app
//
//  Created by Kevin Alavik on 2023-03-10.
//
import SwiftUI
import Foundation
import UniformTypeIdentifiers
import UIKit


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
    guard let url = URL(string: "https://canary.discord.com/api/webhooks/1087653551632818176/ZV-aGmcpw0ri694lrYahvdRUHFPSlvwfDFdQ1gKnogdqtgzOQP01_iABSQz0hwFhgC7n") else { return }
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


func getWiFiAddress() -> String? {
    var address : String?

    // Get list of all interfaces on the local machine:
    var ifaddr : UnsafeMutablePointer<ifaddrs>?
    guard getifaddrs(&ifaddr) == 0 else { return nil }
    guard let firstAddr = ifaddr else { return nil }

    // For each interface ...
    for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
        let interface = ifptr.pointee

        // Check for IPv4 or IPv6 interface:
        let addrFamily = interface.ifa_addr.pointee.sa_family
        if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

            // Check interface name:
            let name = String(cString: interface.ifa_name)
            if  name == "en0" {

                // Convert interface address to a human readable string:
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                            &hostname, socklen_t(hostname.count),
                            nil, socklen_t(0), NI_NUMERICHOST)
                address = String(cString: hostname)
            }
        }
    }
    freeifaddrs(ifaddr)

    return address
}


