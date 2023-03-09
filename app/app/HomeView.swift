//
//  HomeView.swift
//  scylla
//
//  Created by Rayan Khan on 2/28/23.
//
import SwiftUI
let scyllaVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

struct HomeView: View {
    @State private var showAlert = false
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
            List {
                Section("Failed to fetch repo") {
                    HStack {
                        Text("Failed to fetch repo, Error: 501")
                            .foregroundColor(.red)
                    }
                }
                //MARK: Custom Cert
                Section("Custom Cert") {
                    HStack {
                        Image(systemName: "checkmark.seal")
                        Button(action: {showingAlert = true}) {Text("Select existing cert").tint(.pink)}.alert(isPresented: $showingAlert) {Alert(title: Text("This is an beta!"), message: Text("Some stuff are disabled \n(Such as repos, custom certs)"), dismissButton: .default(Text("Got it!")))}
                    }
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        Button(action: {showingAlert = true}) {Text("Import custom cert").tint(.pink)}.alert(isPresented: $showingAlert) {Alert(title: Text("This is an beta!"), message: Text("Some stuff are disabled \n(Such as repos, custom certs)"), dismissButton: .default(Text("Got it!")))}
                    }
                }
            }
            .navigationTitle("Scylla")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showingAlert = true
                        
                    }) {
                        Image(systemName: "shippingbox.fill")
                    }.alert(isPresented: $showingAlert) {Alert(title: Text("This is an beta!"), message: Text("Some stuff are disabled \n(Such as repos, custom certs)"), dismissButton: .default(Text("Got it!")))}.tint(.pink)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAlert = true
                    }) {
                        Image(systemName: "signature")
                    }.alert(isPresented: $showingAlert) {Alert(title: Text("This is an beta!"), message: Text("Some stuff are disabled \n(Such as repos, custom certs)"), dismissButton: .default(Text("Got it!")))}.tint(.pink)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
