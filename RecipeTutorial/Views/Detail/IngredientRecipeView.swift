//
//  IngredientRecipeView.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 6/27/23.
//

import SwiftUI

struct IngredientRecipeView: View {
    var recipe: RecipeInfo
    @State var ingredientNames: [String] = []
    var body: some View {
        ScrollView{
            AsyncImage(url: URL(string: recipe.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color((.gray))]), startPoint: .top, endPoint: .bottom))
            
            VStack(spacing: 30){
                Text(recipe.title)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            
            
            VStack(alignment: .leading,spacing: 30){
                
                if !(recipe.cookingMinutes.words.isEmpty || recipe.servings.words.isEmpty || recipe.readyInMinutes.words.isEmpty){
                    
                    HStack(){
                        PrettyInfoBox(imageText: "clock", text: "Cook Time", data: recipe.cookingMinutes, dataString: "min")
                        PrettyInfoBox(imageText: "spoon", text: "Amount", data: recipe.servings, dataString: "Serv.")
                        PrettyInfoBox(imageText: "clock", text: "Ready Minutes", data: recipe.readyInMinutes, dataString: "min")
                        
                    }
                    
                }
                
                if !recipe.summary.isEmpty
                {
                    let data = Data(recipe.summary.utf8)
                    if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil).string{
                        Text(attributedString)
                    }
                }
            
                if !recipe.analyzedInstructions.debugDescription.isEmpty{
                    
                    let steps = recipe.analyzedInstructions?[0].steps
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text("Ingredients")
                            .font(.headline)
                       
                     //   ForEach(steps ?? [Step(number: 1, step: "Could not find any steps...")], id: \.self) { step in
                            ForEach(steps?[0].ingredients ?? [Ingredient(id: 1, name: "Could not find any ingredients for this particular recipe...", image: "no image")]) { ingredient in
                                
                                Text("\(ingredient.name)")
                            }
                    //    }
                        
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text("Directions")
                            .font(.headline)
                        
                         
                        ForEach(steps ?? [Step(number: 1, step: "Could not find any steps...")], id: \.self) { step in
                            HStack {
                                Text("\(step.number)")
                                    .bold()
                                    .padding(10)
                                    .background(.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                Text("\(step.step)")
                            }
                        }
                        
                    }
                    

                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 40)
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}

struct IngredientRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRecipeView(recipe: RecipeInfo.recipeInfoTest[0])
    }
}
