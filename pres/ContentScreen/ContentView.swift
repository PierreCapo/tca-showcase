//
//  ContentView.swift
//  pres
//
//  Created by Pierre Caporossi on 18/10/2022.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewStore: ViewStore<ContentState, ContentAction>

    init(store: Store<ContentState, ContentAction>) {
        viewStore = ViewStore(store)
    }

    var body: some View {
        VStack {
            VStack {
                Text("Current number : " + "\(viewStore.count)")
                
                Button("Increment") { viewStore.send(.increment) }
                Button("Decrement") { viewStore.send(.decrement) }
                
                Button(viewStore.isLoading ? "Loading..." : "Is number valid") {
                    viewStore.send(.checkIsNumberValid)
                }.disabled(viewStore.isLoading)
                
            }
        }.sheet(isPresented: viewStore.binding(
            get: { $0.showAlert },
            send: ContentAction.toggleBottomSheet
        ), content: {
            Text("Number is valid")
        })
    }
}
