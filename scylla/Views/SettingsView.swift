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
let deviceModel = UIDevice.modelName
let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
var systemVersion = UIDevice.current.systemVersion
var sysName = UIDevice.current.systemName
struct SettingsView: View {
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
                        Button(action: {showingAlert = true}) {Text("Select existing cert").tint(.pink)}.alert(isPresented: $showingAlert) {Alert(title: Text("This is an beta!"), message: Text("Some stuff are disabled \n(Such as repos, custom certs)"), dismissButton: .default(Text("Got it!")))}
                    }
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        Button(action: {showingAlert = true}) {Text("Import custom cert").tint(.pink)}.alert(isPresented: $showingAlert) {Alert(title: Text("This is an beta!"), message: Text("Some stuff are disabled \n(Such as repos, custom certs)"), dismissButton: .default(Text("Got it!")))}
                    }
                }
                Section("Credits") {
                    HStack {
                        Image("puffer").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Button("@pufferisadev (Lead Developer)") {UIApplication.shared.open(URL(string: "https://twitter.com/pufferisadev")!)}
                            .foregroundColor(Color.primary)
                        
                    }
                    HStack {
                        Image("beef").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Button("@mrbeef777 (Co Developer)") {UIApplication.shared.open(URL(string: "https://twitter.com/mrbeef777")!)}
                            .foregroundColor(Color.primary)
                    }
                    HStack {
                        Image("sourcelocation").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Button("@sourcelocation (ApplicationManager)") {UIApplication.shared.open(URL(string: "https://twitter.com/sourceloc")!)}
                            .foregroundColor(Color.primary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                          
                    }
                    HStack {
                        Image("iRayanKhan").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Button("Rayan Khan (Contribu𐕣or)") {UIApplication.shared.open(URL(string: "https://twitter.com/iRayanKhan")!)}
                            .foregroundColor(Color.primary)
                    }
                }
                
                Section("Testers") {
                    HStack {
                        
                        Image("1359").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("Mr.")
                    }
                    HStack {
                        Image("JustDie").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("Justdie")
                    }
                }
                //MARK: 🤓 Nerd Info
                Section("🤓 Nerd Info") {
                    HStack {
                        Image(systemName: "gear")
                            .foregroundColor(Color.gray)
                        Text(sysName + " " + systemVersion)
                            .foregroundColor(Color.gray)
                    }
                    HStack {
                        Image(systemName: "iphone")
                            .foregroundColor(Color.gray)
                            .onTapGesture(perform: simpleSuccess)
                        Text(deviceModel)
                            .foregroundColor(Color.gray)
                    }
            
                    HStack {
                        Image(systemName: "number")
                            .foregroundColor(Color.gray)
                            .onTapGesture(perform: simpleSuccess)
                        Text(UIDevice.current.description)
                            .foregroundColor(Color.gray)

                    }
                    HStack {
                        Image(systemName: "moon.stars.fill")
                            .foregroundColor(Color.gray)
                        Text("Scylla Version " + appVersion!)
                            .foregroundColor(Color.gray)
                    }
                    HStack {
                        Image(systemName: "laptopcomputer.and.arrow.down")
                           
                            .foregroundColor(Color.gray)
                        Text(latestCommitID ?? "")
                            .foregroundColor(Color.gray)
                            
                    }
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(Color.gray)
                            .onTapGesture(perform: simpleSuccess)
                        Text("Signed with ")
                            .foregroundColor(Color.gray)
                    }
                    HStack {
                        Image(systemName: "touchid")
                            .foregroundColor(Color.gray)
                            .onTapGesture(perform: simpleSuccess)
                        Text(udid)
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
