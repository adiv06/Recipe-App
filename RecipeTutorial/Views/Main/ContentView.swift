//
//  ContentView.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 2/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabBar()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipesViewModel())
        
    }
}
