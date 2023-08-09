//
//  SearchView.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 4/2/23.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var recipesVM: RecipesViewModel
    //var recipes: [Recipe]
    
    var body: some View {
        NavigationView{
            ScrollView{
                APIDataSearchBar()
                //SearchBar(recipes: recipesVM.recipeResults)
            }
        }
        
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(RecipesViewModel())
    }
}
