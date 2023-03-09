//
//  ContentView.swift
//  scylla
//
//  Created by Kevin Alavik on 2023-02-25.
//
import Foundation
import SwiftUI


struct SignView: View {
    @State private var showingAlert = false
    var body: some View {
        Text("Hello World")
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
    }
}


struct SignView_Previews: PreviewProvider {
    static var previews: some View {
        SignView()
    }
}
