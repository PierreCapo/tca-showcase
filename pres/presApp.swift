//
//  presApp.swift
//  pres
//
//  Created by Pierre Caporossi on 18/10/2022.
//

import SwiftUI

@main
struct presApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: .init(
                initialState: .init(),
                reducer: reducer,
                environment: .init(mainQueue: .main, numberClient: .live)
            ))
        }
    }
}
