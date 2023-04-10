//
//  HomeView.swift
//  scylla
//
//  Created by Kevin Alavik on 2/28/23.
//
import SwiftUI
import UniformTypeIdentifiers
import Foundation
import Kingfisher
import UIKit
import CoreData

let scyllaVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

var mainRepoUrl = "https://puffer.is-a.dev/scylla-ios/cdn/repo.json"


struct HomeView: View {
    @State private var showAlert = false
    @State private var showingAlert = false
    @State private var certImported = true
    @State private var showNoCertAlert = false
    @State private var showAddRepo = false
    @State private var repoData: [Repo] = []
    @State private var repoUrlAdd: String = ""
    //MARK: IMPORTANT VARS
    @State private var reposs = ["https://repo.alexspaces.me/", "https://puffer.is-a.dev/scylla-ios/cdn/repo.json", "https://usescarlet.com/scarlet.json", "https://cdn.altstore.io/file/altstore/apps.json"]
    @State private var repos = ["https://puffer.is-a.dev/scylla-ios/cdn/templateRepo.json", "https://repo.alexspaces.me/", "https://usescarlet.com/scarlet.json", "https://cdn.altstore.io/file/altstore/apps.json", "https://raw.githubusercontent.com/vizunchik/AltStoreRus/master/apps.json", "https://bit.ly/Quantumsource-plus", "https://bit.ly/Altstore-complete", "https://bit.ly/Quantumsource", "https://ipa.cypwn.xyz/scarlet.json", "https://altstore.oatmealdome.me", "https://bit.ly/wuxuslibraryplus", "https://flyinghead.github.io/flycast-builds/altstore.json", "https://theodyssey.dev/altstore/odysseysource.json", "https://puffer.is-a.dev/scylla-ios/cdn/repo.json"]
    @State private var installedApps = [["Scylla", "1.0", "https://puffer.is-a.dev/scylla-ios/cdn/images/scyllalogo.jpg"]]
    //END
    @State private var showingPrivBeta = false
    @State private var repoError: String = ""
    @State private var loadingText = "Loading repos..."
    @State private var appsLoaded = false
    
  var body: some View {
      NavigationView {
          List {
              Section("Installed Apps") {
                  /*VStack {
                      ForEach(installedApps, id: \.self) { app in
                          HStack {
                              KFImage(URL(string:app[2])!)
                                  .resizable()
                                  .frame(width: 50, height: 50)
                                  .cornerRadius(10)
                              VStack {
                                  Text(app[0])
                                      .frame(maxWidth: .infinity, alignment: .leading)
                                  Text(app[1])
                                      .frame(maxWidth: .infinity, alignment: .leading)
                                      .font(.system(size: 10))
                              }

                          }
                      }
                  }*/
                  VStack {
                      HStack {
                          Image("scylla")
                              .resizable()
                              .frame(width: 50, height: 50)
                              .cornerRadius(10)
                              .padding(.top, 10)
                          VStack {
                              Text("Scylla v" + scyllaVersion)
                                  .frame(maxWidth: .infinity, alignment: .leading)
                              Text("com.scylla.app")
                                  .frame(maxWidth: .infinity, alignment: .leading)
                                  .font(.system(size: 10))
                                  .foregroundColor(.gray)
                          }.padding(.top, 10)
                      }.padding(.bottom, 10)
                  }
              }
            Section("Repos") {
                  VStack {
                      if let repoData = repoData {
                          ForEach(repoData) { repoData in
                              HStack {
                                  VStack {
                                      KFImage(URL(string:repoData.META?.repoIcon ?? repoData.Info?.repoIcon ?? "https://pbs.twimg.com/profile_images/1177457687014985729/3rleupvs_400x400.png"))
                                          .resizable()
                                          .frame(width: 50, height: 50)
                                          .cornerRadius(10).padding(.top, 10)
                                  }
                                  VStack {
                                      Text(repoData.META?.repoName ?? repoData.Info?.repoName ?? repoData.name ?? "No Name")
                                          .frame(maxWidth: .infinity, alignment: .leading)
                                      Text(repoData.Info?.repoDescription ?? repoData.subtitle ?? "No Repo Description")
                                          .frame(maxWidth: .infinity, alignment: .leading)
                                          .font(.system(size: 10))
                                          .foregroundColor(.gray)
                                  }.padding(.top, 10)
                              }.padding(.bottom, 10)
                          }
                      } else {
                          Text(loadingText)
                      }
                  }
                VStack {
                    TextField("Repo url: ", text: $repoUrlAdd)
                        .font(.system(size: 14))
                        .autocapitalization(.none)
                    Button("Add Repo") {
                        fetchRepoData(repoUrl: repoUrlAdd) { result in
                            switch result {
                            case .success(let repo):
                                self.repoData.append(repo)
                                appsLoaded = true
                            case .failure(let error):
                                repoError = String(describing: error)
                                print(repoError)
                                loadingText = "Error: " + error.localizedDescription
                            }
                        }
                    }
                }
                  
              }.onAppear(perform: {
                  //createServer(port: 2200, res: "Scylla local Server:\nScylla Version: \(scyllaVersion)\n\(UIDevice.modelName)")
                if certImported { showNoCertAlert = false } else { showNoCertAlert = true }
                  if !appsLoaded {
                      for repoUrl in repos {
                          fetchRepoData(repoUrl: repoUrl) { result in
                              switch result {
                              case .success(let repo):
                                  self.repoData.append(repo)
                                  appsLoaded = true
                              case .failure(let error):
                                  repoError = String(describing: error)
                                  print(repoError)
                                  loadingText = "Error: " + error.localizedDescription
                              }
                          }
                      }
                  }
              })
              
            
              //MARK: Section Repo
              /*Section("Repos") {
                  HStack {
                      Image(systemName: "book")
                      NavigationLink(destination: RepoView()) {
                          Text("Manage repos")
                      }
                  }
              }*/
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
                Button(action: {
                    showAddRepo = true
                }) {
                    Image(systemName: "shippingbox.fill")
                    
                }
              }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SignView()) {
                    Image(systemName: "signature")
                }
            }
          }
        }
    }
    /*func promptForRepo() {
        let ac = UIAlertController(title: "Enter repo url", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Add", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            repos.append(answer)
        }
        let closeAction = UIAlertAction(title: "Close", style: .default) { [unowned ac] _ in
            
        }

        ac.addAction(submitAction)
        ac.addAction(closeAction)
        
        present(ac, animated: true)
    }*/

}
