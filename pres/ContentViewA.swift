//
//  ContentView.swift
//  pres
//
//  Created by Pierre Caporossi on 18/10/2022.
//

import SwiftUI

struct User {}

class AppState: ObservableObject {
    @Published var count: Int = 0
    
    @Published var user: User? = nil
}

struct ContentViewA: View {
    @ObservedObject var state = AppState()
    @State var isLoading: Bool = false
    @State var showAlert: Bool = false

    var body: some View {
        VStack {
            VStack {
                Text("Current number : " + "\(state.count)")
                Button("Increment") {
                    state.count = state.count + 1
                }
                Button("Decrement") {
                    state.count = state.count - 1
                }
                Button(isLoading ? "Loading..." : "Is number valid") {
                    isValidNumber(state.count) { result in showAlert = result }
                }.disabled(isLoading)
            }
        }.sheet(isPresented: $showAlert, content: {
            Text("Number is valid")
        })
    }

    func isValidNumber(_ number: Int, onResponse: @escaping (Bool) -> Void) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // some API call here
            let isEven = number % 2 == 0
            onResponse(isEven)
            isLoading = false
        }
    }
}
