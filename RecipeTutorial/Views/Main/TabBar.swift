//
//  TabBar.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 3/13/23.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            /*CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "square.fill.text.grid.1x2")
                }
             */
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            IngredientResultDisplay()
                .tabItem {
                    Label("Ingredients", systemImage: "lightbulb")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            
            FoodPreferencesView()
                .tabItem {
                    Label("Inventory", systemImage: "gear")
                }
            
            
            
            
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .environmentObject(RecipesViewModel())
    }
}
