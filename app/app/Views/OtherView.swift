//
//  ContentView.swift
//  scylla
//
//  Created by Kevin Alavik on 2023-02-25.
//
import Foundation
import SwiftUI

let deviceModel = UIDevice.modelName
let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
var systemVersion = UIDevice.current.systemVersion
var sysName = UIDevice.current.systemName
let repositoryUrl = "https://api.github.com/repos/KevinAlavik/scylla-ios/commits"


struct OtherView: View {
    @State private var showingAlert = false
    @State private var releaseURL: URL? = nil
    @State private var showAlert = false
    @State private var udid = UIDevice.current.identifierForVendor!.uuidString
    @State private var outPort: String = "2212"
    @State private var outPut: Bool = false
    @State private var bigRepo: Bool = false
    @State private var lazzy: Bool = true
    @State private var sourceLinks: Bool = false
    @State private var themes: Bool = false
    @State private var localServer: Bool = false
    @State private var installPort: String = "2213"
    @State private var codeCustom: Bool = false
    @State private var codeUrl: String = "puffer.is-a.dev/scylla-ios/api/sign"
    var body: some View {
        NavigationView {
            List {
                //MARK: Credits
                Section("Credits") {
                    HStack {
                        Image("puffer").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Button("pufferisadev (Lead Developer)") {UIApplication.shared.open(URL(string: "https://twitter.com/pufferisadev")!)}
                            .foregroundColor(Color.primary)
                        
                    }
                    HStack {
                        Image("beef").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Button("mrbeef777 (Developer)") {UIApplication.shared.open(URL(string: "https://twitter.com/mrbeef777")!)}
                            .foregroundColor(Color.primary)
                    }
                    HStack {
                        Image("iRayanKhan").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Button("Rayan Khan (Contributor)") {UIApplication.shared.open(URL(string: "https://twitter.com/iRayanKhan")!)}
                            .foregroundColor(Color.primary)
                    }
                }
                //MARK: Testers
                Section("Testers") {
                    HStack {
                        
                        Image("1359").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("Mr.")
                    }
                    HStack {
                        Image("JustDie").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("Justdie")
                    }
                    HStack {
                        Image("Madhav").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("Madhav")
                    }
                    HStack {
                        Image("Kixrd").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("Kixrd")
                    }
                }
                //MARK: Debug
                Section("Debugging") {
                    HStack(spacing: 10) {
                        Text("Output to port: ")
                        TextField("", text: $outPort)
                    }
                    HStack(spacing: 10) {
                        Text("Enable output to \(getWiFiAddress()! + ":" + outPort )")
                        Toggle("", isOn: $outPut)
                    }
                }
                //MARK: Experimental
                Section("⚠️ Experimental") {
                    HStack(spacing: 10) {
                        Text("Enable support for big repos")
                        Toggle("", isOn: $bigRepo)
                    }
                    if bigRepo {
                        HStack(spacing: 10) {
                            VStack {
                                Text("Lazzy loading")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("(Disable only if you know what you are doing)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 10))
                            }
                            Toggle("", isOn: $lazzy)
                        }
                    }
                    HStack(spacing: 10) {
                        Text("Enable support for Esign source links")
                        Toggle("", isOn: $sourceLinks)
                    }
                    HStack(spacing: 10) {
                        Text("Enable themes")
                        Toggle("", isOn: $themes)
                    }
                    HStack(spacing: 10) {
                        Text("Use local server to install apps")
                        Toggle("", isOn: $localServer)
                    }
                    if localServer {
                        HStack(spacing: 10) {
                            Text("Use port: ")
                            TextField("", text: $installPort)
                        }
                    }
                    HStack(spacing: 10) {
                        Text("Use custom codesign api")
                        Toggle("", isOn: $codeCustom)
                    }
                    if codeCustom {
                        HStack(spacing: 10) {
                            Text("Custom URL/IP")
                            TextField("", text: $codeUrl)
                        }
                    }
                    
                }
                //MARK: 🤓 Nerd Info
                Section("🤓 Nerd Info") {
                    HStack(spacing: 10) {
                        Text("❌ Failed to start server")
                    }
                    HStack(spacing: 10) {
                        Image(systemName: "gear")
                            .foregroundColor(Color.gray)
                        Text(sysName + " " + systemVersion)
                            .foregroundColor(Color.gray)
                    }
                    HStack(spacing: 10) {
                        Image(systemName: "iphone")
                            .foregroundColor(Color.gray)
                            .onTapGesture(perform: simpleSuccess)
                        Text(deviceModel)
                            .foregroundColor(Color.gray)
                    }
            
                    HStack(spacing: 10) {
                        Image(systemName: "number")
                            .foregroundColor(Color.gray)
                            .onTapGesture(perform: simpleSuccess)
                        Text(UIDevice.current.description)
                            .foregroundColor(Color.gray)

                    }
                    HStack(spacing: 10) {
                        Image(systemName: "moon.stars.fill")
                            .foregroundColor(Color.gray)
                        Text("Scylla Version " + appVersion!)
                            .foregroundColor(Color.gray)
                    }
                    HStack(spacing: 10) {
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
            .onAppear(perform: {
            })
        }
    }
}

struct OtherView_Previews: PreviewProvider {
    static var previews: some View {
        OtherView()
    }
}





func simpleSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}
