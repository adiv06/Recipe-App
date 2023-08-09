//
//  FavoritesView.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 2/27/23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var recipesVM: RecipesViewModel
    
    
    
    var body: some View {
        NavigationView{
            
        }
        .navigationTitle("Testing 1 2 3")
        
        
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(RecipesViewModel())
    }
}
