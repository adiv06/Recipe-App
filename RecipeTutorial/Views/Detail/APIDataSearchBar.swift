//
//  APIDataSearchBar.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 4/16/23.
//

import SwiftUI

struct APIDataSearchBar: View {
    @EnvironmentObject var recipesVM: RecipesViewModel
    
    @State var searchText = ""
    @State var tempText = ""
    @State var debounce_timer: Timer?
    @State var displayNoSearchImage: Bool = false
    @State static var loadResults: Bool = true

    

        
    var body: some View {
        LazyVStack {
            TextField("Type Something...", text: $searchText)
                .padding()
                .background(.gray.opacity(0.15))
                .cornerRadius(15)
                
                .onChange(of: searchText) {_ in
                    
                    APIDataSearchBar.loadResults = false
                    debounce_timer?.invalidate()
                    //Inerval is the delay of the search results
                    debounce_timer =
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
                        if(searchText != ""){
                            recipesVM.getRecipeSearchResults(query: searchText)
                        }
                        
                        
                        
                        //recipes = recipesVM.recipeResults
                        
                     }
                    //API CALL
                    
                }
            
            
            
            if(APIDataSearchBar.loadResults){
                ForEach(recipesVM.recipeResults){ recipe in
                    NavigationLink(destination: RecipeView(recipe: recipe))
                    {
                        SearchResultCards(recipe: recipe)
                            .padding(.vertical, 5)
                        
                    }
                }
            }
                            
        }
        .navigationTitle("Recipe Search")
        .padding(.horizontal)
        }
    }

struct APIDataSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            APIDataSearchBar(/*recipes: RecipeSearchResult.test*/)
                .environmentObject(RecipesViewModel())
        }
    }
}
