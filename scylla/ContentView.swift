//
//  ContentView.swift
//  scylla
//
//  Created by Kevin Alavik on 2023-02-25.
//

import SwiftUI


extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

func simpleSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

import Foundation

let repositoryUrl = "https://api.github.com/repos/KevinAlavik/scylla-ios/commits"

let getLatestCommitID: () -> String? = {
    let semaphore = DispatchSemaphore(value: 0)
    var commitID: String?
    
    let url = URL(string: "\(repositoryUrl)?per_page=1")!
    let request = URLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        defer { semaphore.signal() }
        
        guard let data = data else {
            print(error?.localizedDescription ?? "Unknown error")
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
               let commit = json.first,
               let sha = commit["sha"] as? String {
                commitID = String(sha.prefix(7))
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    task.resume()
    semaphore.wait()
    
    return commitID
}

let latestCommitID = getLatestCommitID()

var systemVersion = UIDevice.current.systemVersion
var sysName = UIDevice.current.systemName
struct ContentView: View {
    @State private var showingAlert = false
    @State private var releaseURL: URL? = nil
    @State private var showAlert = false
    @State private var udid = UIDevice.current.identifierForVendor!.uuidString
    var body: some View {
        NavigationView {
            List {
                Section("Failed to fetch repo") {
                    HStack {
                        Text("Failed to fetch repo, Error: 501")
                            .foregroundColor(.red)
                    }
                }
                Section("Custom Cert") {
                    HStack {
                        Image(systemName: "checkmark.seal")
                        Button(action: {showingAlert = true}) {Text("Select existing cert").tint(.pink)}.position(x: 75, y: 15).alert(isPresented: $showingAlert) {Alert(title: Text("This is an beta!"), message: Text("Some stuff are disabled \n(Such as repos, custom certs)"), dismissButton: .default(Text("Got it!")))}
                    }
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        Button(action: {showingAlert = true}) {Text("Import custom cert").tint(.pink)}.position(x: 80, y: 15).alert(isPresented: $showingAlert) {Alert(title: Text("This is an beta!"), message: Text("Some stuff are disabled \n(Such as repos, custom certs)"), dismissButton: .default(Text("Got it!")))}
                    }
                }
                Section("Credits") {
                    HStack {
                        Image("puffer").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("@pufferisadev (Lead Developer)").position(x: 130, y: 15)
                    }
                    HStack {
                        Image("beef").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("@mrbeef777 (Co Developer)").position(x: 115, y: 15)
                    }
                    HStack {
                        Image("sourcelocation").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("@sourcelocation (ApplicationManager)").position(x: 155, y: 15)
                    }
                }
                
                Section("Testers") {
                    HStack {
                        Image("1359").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("Mr.").position(x: 20, y: 15)
                    }
                    HStack {
                        Image("JustDie").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("Justdie").position(x: 35, y: 15)
                    }
                }
                Section("🤓 Nerd Info") {
                    HStack {
                        Image(systemName: "gear")
                            .foregroundColor(Color.gray)
                        Text(sysName + " " + systemVersion).position(x: 35, y: 15)
                            .foregroundColor(Color.gray)
                    }
                    HStack {
                        Image(systemName: "iphone")
                            .foregroundColor(Color.gray)
                            .onTapGesture(perform: simpleSuccess)
                        Text(UIDevice.current.model).position(x: 35, y: 15)
                            .foregroundColor(Color.gray)
                    }
                    HStack {
                        Image(systemName: "number")
                            .foregroundColor(Color.gray)
                            .onTapGesture(perform: simpleSuccess)
                        Text(UIDevice.current.description).position(x: 125, y: 15)
                            .foregroundColor(Color.gray)

                    }
                    HStack {
                        Image(systemName: "moon.stars.fill")
                            .foregroundColor(Color.gray)
                        Text("Scylla Version 0.1").position(x: 70, y: 15)
                            .foregroundColor(Color.gray)
                    }
                    HStack {
                        Image(systemName: "laptopcomputer.and.arrow.down")
                            .foregroundColor(Color.gray)
                        Text(latestCommitID ?? "").position(x: 30, y: 15)
                            .foregroundColor(Color.gray)
                    }
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(Color.gray)
                            .onTapGesture(perform: simpleSuccess)
                        Text("Signed with ").position(x: 50, y: 15)
                            .foregroundColor(Color.gray)
                    }
                    HStack {
                        Image(systemName: "touchid")
                            .foregroundColor(Color.gray)
                            .onTapGesture(perform: simpleSuccess)
                        Text(udid).position(x: 140, y: 15)
                            .foregroundColor(Color.gray)
                            .font(.system(size: 12.5))
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
        }.background(
            Image("background")
                .resizable()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
