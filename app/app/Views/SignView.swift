//
//  ContentView.swift
//  scylla
//
//  Created by Kevin Alavik on 2023-02-25.
//
import Foundation
import SwiftUI

struct SignView: View {
    @State private var showingAlert = false
    @State private var customAppName: String = ""
    @State private var customBundleId: String = ""
    var body: some View {
        VStack {
            Text("Sign IPA")
                .font(.system(size: 30))
                .position(x: UIScreen.screenWidth/2, y:500)
            
            HStack {
                Button("Select IPA") {
                    openDocumentPicker(fileExtension: "ipa", allowMultiple: false)
                }.buttonStyle(.borderedProminent).tint(.pink)
                HStack {
                    Button("Select Cert") {
                        openDocumentPicker(fileExtension: "yml", allowMultiple: false)
                    }.buttonStyle(.borderedProminent).tint(.pink)
                }
            }
            
            HStack {
                TextField("Custom App Name: ", text: $customAppName)
                    .font(.system(size: 10))
                    .frame(width: 218)
            }
            .textFieldStyle(.roundedBorder)
            .frame(width: 305)
            HStack {
                TextField("Custom Bundle ID: ", text: $customBundleId)
                    .font(.system(size: 10))
                    .frame(width: 218)
            }
            .textFieldStyle(.roundedBorder)
            .frame(width: 305)
            
            HStack {
                Button() {
                } label: {
                    Text("Sign")
                        .frame(width: 195)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .tint(.pink)
            }
        }
        .position(x: UIScreen.screenWidth/2, y: UIScreen.screenHeight/2-350)
    }
}


struct SignView_Previews: PreviewProvider {
    static var previews: some View {
        SignView()
    }
}
