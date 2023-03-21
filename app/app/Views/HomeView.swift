//
//  HomeView.swift
//  scylla
//
//  Created by Kevin Alavik on 2/28/23.
//
import SwiftUI
import UniformTypeIdentifiers
import Foundation

let scyllaVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
var repoData: String = ""

struct PrivateBeta: View {
    @Environment(\.dismiss) var dismiss
    @State private var key: String = ""
    var body: some View {
        Image(systemName: "exclamationmark.triangle").resizable().frame(width: 75.0, height: 75.0)
            .tint(.yellow)
            .padding()
            .onAppear {
                getSecretKey()
            }
        Text("This is a private beta!")
            .font(.headline)
        Text("Please do not share it!")
            .font(.caption)
            .padding()
        VStack {
            Text("Secret key (Check the #secret-keys channel for the newest key)")
            TextField("******", text: $key)
        }.frame(width: 280).textFieldStyle(.roundedBorder)
        Button("Continue", action: close)
            .buttonStyle(.borderedProminent).tint(.pink)
            .padding()
        Text("(Keep in mind this is an beta feautures might be broken)")
            .foregroundColor(.gray)
            .font(.footnote)
        
        
            .interactiveDismissDisabled()
    }
    
    func close() {
        if (checkSecretKey(inpt: key)) { dismiss() }
    }
}

struct HomeView: View {
  @State private var showAlert = false
  @State private var showingAlert = false
  @State private var mainRepoUrl =
    "https://puffer.is-a.dev/scylla-ios/cdn/repoTemplate.json"
  @State private var certImported = true
  @State private var showNoCertAlert = false
  @ObservedObject var repoData = RepoModel()
  @State private var showingPrivBeta = true
  var body: some View {
    NavigationView {
      List {
        Section("WIP") {
          VStack {
              Text("Work in progress")
          }.onAppear(perform: {
            repoData.fetchData(repoUrl: mainRepoUrl)
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
            Image(systemName: "square.and.arrow.down")
            NavigationLink(destination: SelectCertView()) {
                Text("Select Certificate")
                    .foregroundColor(.pink)
            }.tint(.pink)
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
    }).sheet(isPresented: $showingPrivBeta, content: PrivateBeta.init)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
