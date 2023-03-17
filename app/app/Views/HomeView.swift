//
//  HomeView.swift
//  scylla
//
//  Created by Kevin Alavik on 2/28/23.
//
import SwiftUI

let scyllaVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
var repoData: String = ""

struct HomeView: View {
  @State private var showAlert = false
  @State private var showingAlert = false
  @State private var mainRepoUrl =
    "https://puffer.is-a.dev/scylla-ios/cdn/repoTemplate.json"
  @State private var certImported = true
  @State private var showNoCertAlert = false
  @ObservedObject var repoModel = RepoModel()
  var body: some View {
    NavigationView {
      List {
        Section("Testing") {
          VStack {
              List(repoModel.items, id: \.Info.repoName) { item in
              VStack(alignment: .leading) {
                  Text("\(item.Info?.repoName ?? "Cannot parse name")")
                  Text("\(item.Info?.repoAuthor ?? "Cannot parse author")")
                      .font(.system(size: 11))
                      .foregroundColor(.gray)
              }
            }.listStyle(GroupedListStyle())
          }.onAppear(perform: {
            repoModel.fetchData(repoUrl: mainRepoUrl)
          })
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
            Button(action: { showingAlert = true }) {
              Text("Select Custom Certificate").tint(.pink)
            }.alert(isPresented: $showingAlert) {
              Alert(
                title: Text("Work in progress"), message: Text("We are working on it "),
                dismissButton: .default(Text("Got it!")))
            }
          }
        }.alert(isPresented: $showNoCertAlert) {
          Alert(
            title: Text("No Cert Imported!"), message: Text("You havent imported any certs!"),
            primaryButton: .destructive(Text("Dissmiss")),
            secondaryButton: .default(Text("Import Certificate")))
        }
      }
      .navigationTitle("Scylla")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {
            showingAlert = true

          }) {
            Image(systemName: "shippingbox.fill")
          }.alert(isPresented: $showingAlert) {
            Alert(
              title: Text("This is an beta!"),
              message: Text("Some stuff are disabled \n(Such as repos, custom certs)"),
              dismissButton: .default(Text("Got it!")))
          }.tint(.pink)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            showingAlert = true
          }) {
            Image(systemName: "signature")
          }.alert(isPresented: $showingAlert) {
            Alert(
              title: Text("This is an beta!"),
              message: Text("Some stuff are disabled \n(Such as repos, custom certs)"),
              dismissButton: .default(Text("Got it!")))
          }.tint(.pink)
        }
      }
    }.onAppear(perform: {
      if certImported { showNoCertAlert = false } else { showNoCertAlert = true }
    })
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
