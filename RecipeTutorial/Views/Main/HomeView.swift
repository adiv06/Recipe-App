//
//  HomeView.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 2/27/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var recipesVM: RecipesViewModel
    var body: some View {
        NavigationView{
            ScrollView{
                
                
                RecipeList(recipes: recipesVM.recipeResults)
            }
            .navigationTitle("My Recipes")
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RecipesViewModel())
    }
}
