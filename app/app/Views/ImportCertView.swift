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
        Text("Import Certificate")
            .font(.system(size: 30))
            .position(x: UIScreen.screenWidth/2, y: 150)
        
        VStack {
            HStack {
                Button("Select p12 and mobileprovision") {
                    openDocumentPicker(fileExtension: "json", allowMultiple: true)
                }.buttonStyle(.borderedProminent).tint(.pink)
            }
            
            HStack {
                TextField("Password (leave blank if there is none): ", text: $certPass)
                    .font(.system(size: 10))
            }
            .textFieldStyle(.roundedBorder)
            .frame(width: 260)
            
            HStack {
                Button() {
                } label: {
                    Text("Add certificate")
                        .frame(width: 235)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .tint(.pink)
            }
        }
        .position(x: UIScreen.screenWidth/2, y: 0)
    }
}

struct ImportCertView_Previews: PreviewProvider {
    static var previews: some View {
        ImportCertView()
    }
}
