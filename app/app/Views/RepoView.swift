//
//  ContentView.swift
//  scylla
//
//  Created by Kevin Alavik on 2023-02-25.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct RepoView: View {
    @State private var showingAlert = false
    @State private var certPass: String = ""
    var body: some View {
        NavigationView {
            List {
                Section("Imported Repo(s)") {
                    HStack {
                        Image("scylla")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        VStack {
                            Text("Base Repo")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("https://puffer.is-a.dev/scylla-ios/cdn/repo.json")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 10))
                        }
                    }
                    HStack {
                        Image("scylla")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        VStack {
                            Text("Template Repo")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("https://puffer.is-a.dev/scylla-ios/cdn/templateRepo.json")
                                .frame(alignment: .leading)
                                .font(.system(size: 10))
                        }
                        Button(action: {
                            
                        }) {
                          Image(systemName: "minus.circle.fill")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                Section("Community Repos") {
                    HStack {
                        Image("scylla")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        VStack {
                            Text("Placeholder")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("https://puffer.is-a.dev/scylla-ios/cdn/repo.json")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 10))
                        }
                        Button(action: {
                            
                        }) {
                          Image(systemName: "plus.circle.fill")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    HStack {
                        Image("scylla")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        VStack {
                            Text("Placeholder")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("https://puffer.is-a.dev/scylla-ios/cdn/repo.json")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 10))
                        }
                        Button(action: {
                            
                        }) {
                          Image(systemName: "plus.circle.fill")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    HStack {
                        Image("scylla")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        VStack {
                            Text("Placeholder")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("https://puffer.is-a.dev/scylla-ios/cdn/repo.json")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 10))
                        }
                        Button(action: {
                            
                        }) {
                          Image(systemName: "plus.circle.fill")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    HStack {
                        Image("scylla")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        VStack {
                            Text("Placeholder")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("https://puffer.is-a.dev/scylla-ios/cdn/repo.json")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 10))
                        }
                        Button(action: {
                            
                        }) {
                          Image(systemName: "plus.circle.fill")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
            }.position(x: UIScreen.screenWidth/2, y: 200)
            
        }
        .navigationTitle("Repos")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
    }
}

struct RepoView_Previews: PreviewProvider {
    static var previews: some View {
        RepoView()
    }
}
