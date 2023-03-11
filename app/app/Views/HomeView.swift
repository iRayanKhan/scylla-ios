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
    @State private var repoName: String = ""
    @State private var repoAuthor: String = ""
    @State private var repoData: Array<String> = []
    @State private var repoVer: String = ""
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(repoName), footer: Text("Repo Author: " + repoAuthor + ", Repo Version: " + repoVer)) {
                    HStack {
                        if !repoName.isEmpty {
                            
                        } else {
                            Text("Loading repo data...")
                        }
                    }
                }.onAppear {
                    getRepo(repoUrl: "https://raw.githubusercontent.com/KevinAlavik/scylla-ios/main/repo.json") { (repoData) in
                        DispatchQueue.main.async {
                            if let name = repoData?["repoName"] as? String {
                                self.repoName = name
                            } else {
                                self.repoName = "Failed to load repo name"
                                self.repoAuthor = "Failed to load repo author"
                                self.repoVer = "Failed to load repo version"
                                self.repoData = []
                            }
                            if let author = repoData?["repoAuthor"] as? String {
                                self.repoAuthor = author
                            }
                            if let ver = repoData?["repoVersion"] as? Double {
                                self.repoVer = "\(ver)"
                            }
                            if let apps = repoData?["apps"] as? [[String: Any]] {
                                for app in apps {
                                    if let data = app as? String {
                                        var appName = app["name"]
                                        var appLink = app["ipaLink"]
                                        var appIcon = app["iconLink"]
                                        var appVersion = app["version"]
                                        var appInfo = appName + " " + appLink + " " + appIcon + " " + appVersion
                                        print(appInfo)
                                    }
                                }
                            }

                        }
                    }
                }
                //MARK: Custom Cert
                Section("Custom Cert") {
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        NavigationLink(destination: ImportCertView()) {
                            Text("Import Certificate")
                                .foregroundColor(.pink)
                        }.tint(.pink)
                    }
                    HStack {
                        Image(systemName: "checkmark.seal")
                        Button(action: {showingAlert = true}) {Text("Select Custom Certificate").tint(.pink)}.alert(isPresented: $showingAlert) {Alert(title: Text("Work in progress"), message: Text("We are working on it "), dismissButton: .default(Text("Got it!")))}
                    }
                }.alert(isPresented: $showNoCertAlert) {Alert(title: Text("No Cert Imported!"), message: Text("You havent imported any certs!"), primaryButton: .destructive(Text("Dissmiss")), secondaryButton: .default(Text("Import Certificate")))}
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
