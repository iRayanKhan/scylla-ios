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

