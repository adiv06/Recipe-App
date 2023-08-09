//
//  RecipeTutorialApp.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 2/27/23.
//

import SwiftUI

@main
struct RecipeTutorialApp: App {
    @State var recipesViewModel = RecipesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recipesViewModel)
        }
    }
}
