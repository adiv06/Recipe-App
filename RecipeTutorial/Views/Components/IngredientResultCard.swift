//
//  IngredientResultCard.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 6/21/23.
//

import SwiftUI

struct IngredientResultCard: View {
    
    var ingredientInfo: IngredientSearchResult
    var body: some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
            
            HStack(){
                AsyncImage(url: URL(string: ingredientInfo.image)) { image in
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
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                
                //Spacer()
                VStack(alignment: .leading){
                    //Change this later to something relavent
                    Spacer()
                    
                    Text(ingredientInfo.title)
                        .bold()
                        .padding(6)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(5)
                    
                    Text("Uses \(ingredientInfo.usedIngredientCount) ingredients listed")
                        .foregroundColor(.gray)
                }
                .frame(maxHeight: 50)
                .padding(.horizontal)
                Spacer()
            }
            
            
                        
        }
        .frame(height: 100)
        .shadow(color: Color.black.opacity(0.15), radius: 15, x: 0, y: 10)
        .padding(5)
    }
        
}

struct IngredientResultCard_Previews: PreviewProvider {
    static var previews: some View {
        IngredientResultCard(ingredientInfo: IngredientSearchResult.ingredientTest[0])
    }
}
