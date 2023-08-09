//
//  RecipeCard.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 3/13/23.
//

import SwiftUI

struct RecipeCard: View {
    var recipe: RecipeSearchResult
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .overlay(alignment: .top) {
            Text(recipe.title)
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .shadow(color: .black, radius: 3, x: 0, y: 0)
                .frame(maxWidth: 136)
                .padding()
        }
        .frame(width: 160, height: 217, alignment: .top)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color((.gray))]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard(recipe: RecipeSearchResult.test[0])
    }
}
