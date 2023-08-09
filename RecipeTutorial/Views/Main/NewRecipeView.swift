//
//  NewRecipeView.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 2/27/23.
//

import SwiftUI

struct NewRecipeView: View {
    @State private var showAddRecipe = false;
    var body: some View {
        NavigationView{
            Button("Add Recipe Manually"){
                showAddRecipe = true
            }
            
            Image(systemName: "home")
                .onTapGesture {
                    showAddRecipe = true;
                }
            

        }
        .sheet(isPresented: $showAddRecipe) {
            AddRecipeView()
        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
            .environmentObject(RecipesViewModel())
    }
}
