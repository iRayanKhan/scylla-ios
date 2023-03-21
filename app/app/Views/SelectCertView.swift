//
//  ContentView.swift
//  scylla
//
//  Created by Kevin Alavik on 2023-02-25.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct SelectCertView: View {
    @State private var showingAlert = false
    @State private var certPass: String = ""
    @State private var useCertAlways = false
    var body: some View {
        Text("Import Certificate")
            .font(.system(size: 30))
            .position(x: UIScreen.screenWidth/2, y: 150)
        
        VStack {
            HStack {
                Button("Select certificate") {
                    openDocumentPicker(fileExtension: "json", allowMultiple: false)
                }.buttonStyle(.borderedProminent).tint(.pink)
            }
            Toggle(isOn: $useCertAlways) {
                Text("Always use this cert")
            }
        }.position(x: UIScreen.screenWidth/2, y: 0)
    }
}

struct SelectCertView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCertView()
    }
}
