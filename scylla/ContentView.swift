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

var systemVersion = UIDevice.current.systemVersion
var sysName = UIDevice.current.systemName

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        
        NavigationView {
            List {
                Section("Recomended Apps") {
                    HStack {
                        Image("cowabunga").resizable().frame(width: 25.0, height: 25.0)
                        Text("Cowabunga").position(x: 50, y: 15)
                        Button("Install") {
                            print("install app")
                        }.position(x: 120, y: 15)
                    }
                }
                Section("Other Apps") {
                    HStack {
                        Image("enmity").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("Enmity").position(x: 35, y: 15)
                        Button("Install") {
                            print("install app")
                        }.position(x: 120, y: 15)
                    }
                }
                Section("Jailbreaks") {
                    HStack {
                        Image("unc0ver").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("Unc0ver").position(x: 35, y: 15)
                        Button("Install") {
                            print("install app")
                        }.position(x: 120, y: 15)
                    }
                }
                Section("MacDirtyCow (Only supports up to iOS 16.1.2)") {
                    HStack {
                        Image("cowabunga").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("Cowabunga").position(x: 50, y: 15)
                        Button("Install") {
                            print("install app")
                        }.position(x: 120, y: 15)
                    }
                    HStack {
                        Image("fsp").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("FileSwitcherPro").position(x: 65, y: 15)
                        Button("Install") {
                            print("install app")
                        }.position(x: 120, y: 15)
                    }
                    HStack {
                        Image("dc").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("DynamicCow").position(x: 55, y: 15)
                        Button("Install") {
                            print("install app")
                        }.position(x: 120, y: 15)
                    }
                    HStack {
                        Image("resset16").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("ResSet16").position(x: 40, y: 15)
                        Button("Install") {
                            print("install app")
                        }.position(x: 120, y: 15)
                    }
                    HStack {
                        Image("ccenabler").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("CCEnabler").position(x: 45, y: 15)
                        Button("Install") {
                            print("install app")
                        }.position(x: 120, y: 15)
                    }
                }
                Section("TrollStore Apps") {
                    HStack {
                        Image("trollbox").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("TrollBox").position(x: 35, y: 15)
                        Button("Install") {
                            print("install app")
                        }.position(x: 120, y: 15)
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
                        Text("puffer (Lead Developer)").position(x: 100, y: 15)
                    }
                    HStack {
                        Image("beef").resizable().frame(width: 25.0, height: 25.0).cornerRadius(5)
                        Text("beef (Co Developer)").position(x: 85, y: 15)
                    }
                }
                Section("Nerd Info") {
                    HStack {
                        Image(systemName: "gear")
                            .foregroundColor(Color.gray)
                        Text(sysName + " " + systemVersion).position(x: 35, y: 15)
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
                        Text("3671d0b").position(x: 30, y: 15)
                            .foregroundColor(Color.gray)
                    }
                }
            }
            .navigationTitle("Scylla")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showingAlert = true
                        
                    }) {
                        Image(systemName: "plus.circle")
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
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
