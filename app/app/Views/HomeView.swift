//
//  HomeView.swift
//  scylla
//
//  Created by Kevin Alavik on 2/28/23.
//
import SwiftUI
import UniformTypeIdentifiers
import Foundation

let scyllaVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
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
        Text("(Keep in mind this is a beta, features might be broken)")
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
    "https://puffer.is-a.dev/scylla-ios/cdn/repo.json"
  @State private var certImported = true
  @State private var showNoCertAlert = false
  @State private var repoData: Repo?
  @State private var showingPrivBeta = false
  @State private var repoError: String = ""
  @State private var loadingText = "Loading..."
  var body: some View {
      NavigationView {
          List {
              Section("Apps") {
                  VStack {
                      if let data = repoData {
                          ForEach(data.data) { repoData in
                              Text("Repo Name: \(repoData.Info?.repoName ?? "No Name")\n")
                              Text("Repo Author: \(repoData.Info?.repoAuthor ?? "No Author")\n")
                              Text("Repo Version: \(repoData.Info?.repoVersion ?? "No Version")\n")
                              Text("Repo Description: \(repoData.Info?.repoDescription ?? "No Description")\n")
                              
                          }
                      } else {
                          Text(loadingText)
                      }
                  }.onAppear {
                      fetchRepoData(repoUrl: "https://puffer.is-a.dev/scylla-ios/cdn/templateRepo.json") { result in
                          switch result {
                          case .success(let repo):
                              print(repo)
                              self.repoData = repo
                          case .failure(let error):
                              repoError = String(describing: error)
                              print(repoError)
                              loadingText = "Error: " + error.localizedDescription
                          }
                      }

                  }
              }
              Section("Apps Placeholder") {
                  HStack {
                      Image("scylla")
                          .resizable()
                          .frame(width: 50, height: 50)
                          .cornerRadius(10)
                      VStack {
                          Text("Scylla")
                              .frame(maxWidth: .infinity, alignment: .leading)
                          Text("com.scylla.app")
                              .frame(maxWidth: .infinity, alignment: .leading)
                              .font(.system(size: 10))
                      }
                      Button(action: {
                          
                      }) {
                        Image(systemName: "arrow.down.app.fill")
                              .frame( alignment: .trailing)
                      }
                  }
                  HStack {
                      Image("scylla")
                          .resizable()
                          .frame(width: 50, height: 50)
                          .cornerRadius(10)
                      VStack {
                          Text("Scylla")
                              .frame(maxWidth: .infinity, alignment: .leading)
                          Text("com.scylla.app")
                              .frame(maxWidth: .infinity, alignment: .leading)
                              .font(.system(size: 10))
                      }
                      Button(action: {
                          
                      }) {
                        Image(systemName: "arrow.down.app.fill")
                              .frame( alignment: .trailing)
                      }
                  }
              }
              //MARK: Section Repo
              Section("Repos") {
                  HStack {
                      Image(systemName: "book")
                      NavigationLink(destination: RepoView()) {
                          Text("Manage repos")
                      }
                  }
              }
            //MARK: Custom Cert
            Section("Custom Cert") {
              HStack {
                Image(systemName: "square.and.arrow.down")
                NavigationLink(destination: ImportCertView()) {
                  Text("Import Certificate")
                }
              }
              HStack {
                Image(systemName: "checkmark.circle")
                NavigationLink(destination: SelectCertView()) {
                    Text("Select Certificate")
                }
              }
            }.alert(isPresented: $showNoCertAlert) {
              Alert(
                title: Text("No Cert Imported!"), message: Text("You havent imported any certificates!"),
                primaryButton: .destructive(Text("Dissmiss")),
                secondaryButton: .default(Text("Import Certificate")))
            }
          }
          .navigationTitle("Scylla")
          .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink(destination: RepoView()) {
                    Image(systemName: "shippingbox.fill")
                }
              }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SignView()) {
                    Image(systemName: "signature")
                }
            }
          }
        }.onAppear(perform: {
            //createServer(port: 2200, res: "Scylla local Server:\nScylla Version: \(scyllaVersion)\n\(UIDevice.modelName)")
          if certImported { showNoCertAlert = false } else { showNoCertAlert = true }
        }).sheet(isPresented: $showingPrivBeta, content: PrivateBeta.init)
    }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
      HomeView()
          .preferredColorScheme(.dark)
          .previewDevice("iPhone 13 Pro Max")
          .previewInterfaceOrientation(.portrait)
  }
}
