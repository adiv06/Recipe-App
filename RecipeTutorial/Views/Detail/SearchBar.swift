//
//  SearchBar.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 4/2/23.
//

import SwiftUI

struct SearchBar: View {
    @State var searchText = ""
    @State var tempText = ""
    @State var debounce_timer: Timer?
    @State var loadResults: Bool = true

    
    var recipes: [RecipeSearchResult]
    
    var filteredRecipies: [RecipeSearchResult] {

        return searchText == "" ? recipes.map { $0 } : recipes.map { $0 }.filter{
        $0.title.lowercased().contains(searchText.lowercased())
    }
}
        
    var body: some View {
        LazyVStack {
            TextField("Type Something...", text: $searchText)
                .padding()
                .background(.gray.opacity(0.15))
                .cornerRadius(15)
                
                .onChange(of: searchText) {_ in
                    loadResults = false
                    debounce_timer?.invalidate()
                    //Inerval is the delay of the search results
                    debounce_timer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
                        //API CALL
                        loadResults = true
                        
                     }
                }
            if(loadResults){
                ForEach(filteredRecipies){ recipe in
                    NavigationLink(destination: RecipeView(recipe: recipe))
                    {
                        SearchResultCards(recipe: recipe)
                    }
                }
            }
                            
        }
        .navigationTitle("Recipe Search")
        .padding(.horizontal)
        }
    }
    
    


struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            SearchBar(recipes: RecipeSearchResult.test)
        }
    }
}
