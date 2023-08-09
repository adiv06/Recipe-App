//
//  TestAPICall.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 7/4/23.
//

import SwiftUI

struct TestAPICall: View {
    @EnvironmentObject var recipesVM: RecipesViewModel

    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Button {
                        //recipesVM.testIngredientInfo(testID: [632452,632614,641803,632603,665672])
                    } label: {
                        Text("**Generate Recipes**")
                            .padding()
                            .foregroundColor(.white)
                            .background(.green)
                            .cornerRadius(10)
                    }
                    
                    Spacer()

                    ForEach(recipesVM.extraIngredientResultInfoTest) { info in
                        NavigationLink(destination: IngredientRecipeView(recipe: info))
                        {
                            Text("\(info.title)")
                        }

                    }
                }
            }
            .navigationTitle("Hello")
        }
    }
}

struct TestAPICall_Previews: PreviewProvider {
    static var previews: some View {
        TestAPICall()
            .environmentObject(RecipesViewModel())
    }
}
