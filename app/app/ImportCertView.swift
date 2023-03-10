//
//  ContentView.swift
//  scylla
//
//  Created by Kevin Alavik on 2023-02-25.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

extension UIScreen {
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
}

struct ImportCertView: View {
    @State private var showingAlert = false
    @State private var certPass: String = ""
    
    var body: some View {
        Text("Select cert")
            .font(.system(size: 30))
            .position(x: UIScreen.screenWidth/2, y: 150)
        
        VStack {
            HStack {
                Button("Select p12") {
                    openDocumentPicker(fileExtension: "p12")
                }.buttonStyle(.borderedProminent).tint(.pink)
                
                Button("Select mobileprovision") {
                    openDocumentPicker(fileExtension: "mobileprovision")
                }.buttonStyle(.borderedProminent).tint(.pink)
            }
            
            HStack {
                TextField("Password (leave blank if there is none): ", text: $certPass)
                    .font(.system(size: 10))
            }
            .textFieldStyle(.roundedBorder)
            .frame(width: 305)
            
            HStack {
                Button("Add cert") {
                    // action for add cert button
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
            }
        }
        .position(x: UIScreen.screenWidth/2, y: 0)
    }
    
    func openDocumentPicker(fileExtension: String) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType(filenameExtension: fileExtension)!])
        documentPicker.modalPresentationStyle = .overFullScreen
        
        // Present the document picker
        UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
    }
}

struct ImportCertView_Previews: PreviewProvider {
    static var previews: some View {
        ImportCertView()
    }
}
