//
//  HomeView.swift
//  scylla
//
//  Created by Rayan Khan on 2/28/23.
//
import SwiftUI
let scyllaVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
var repoData: String = "";




struct HomeView: View {
    @State private var showAlert = false
    @State private var showingAlert = false
    @State private var mainRepoUrl = "https://raw.githubusercontent.com/KevinAlavik/scylla-ios/main/repo.json"
    @State private var certImported = true;
    @State private var showNoCertAlert = false;
    
    var body: some View {
        NavigationView {
            List {
                Section("REPO") {
                    HStack {
                        Text(getRepo())
                    }
                }
                //MARK: Custom Cert
                Section("Custom Cert") {
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        NavigationLink(destination: ImportCertView()) {
                            Text("Import Cert")
                                .foregroundColor(.pink)
                        }.tint(.pink)
                    }
                    HStack {
                        Image(systemName: "checkmark.seal")
                        Button(action: {showingAlert = true}) {Text("Select Custom Cert").tint(.pink)}.alert(isPresented: $showingAlert) {Alert(title: Text("Work in progress"), message: Text("We are working on it "), dismissButton: .default(Text("Got it!")))}
                    }
                }.alert(isPresented: $showNoCertAlert) {Alert(title: Text("No Cert Imported!"), message: Text("You havent imported any certs!"), primaryButton: .destructive(Text("Dissmiss")), secondaryButton: .default(Text("Import Cert")))}
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
        }.onAppear(perform: { if certImported { showNoCertAlert = false } else { showNoCertAlert = true } })
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
