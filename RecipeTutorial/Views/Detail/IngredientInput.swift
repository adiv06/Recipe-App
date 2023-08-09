//
//  IngredientInput.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 6/22/23.
//

import SwiftUI

struct IngredientInput: View {
    
    @EnvironmentObject var recipesVM: RecipesViewModel
    @State var ingredientString: String = ""
    @State var inputAlert: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            ScrollView{
                    List {
                        Section(header: Text("New Ingredient")){
                            TextField("Enter an ingredient", text: $ingredientString)
                                .onSubmit {
                                    recipesVM.addIngredient(ingredient: ingredientString)
                                    ingredientString = ""
                                }
                        }
                        
                        Section(header: Text("Ingredient Search List")){
                            ForEach(recipesVM.ingredientsSearched, id: \.self){ ing in
                                Text("\(ing)")
                            }
                            .onDelete(perform: delete)
                            
                        }
                        
                    }.frame(height: UIScreen.main.bounds.height)
                    
                    
                    
                
                //Alert is not presenting do not know why
                    .alert("Input Error", isPresented: $inputAlert) {
                        Button("Input Handler") {
                            inputAlert.toggle()
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(){
                                dismiss()
                            } label: {
                                Label("Cancel", systemImage: "xmark")
                                    .labelStyle(.iconOnly).foregroundColor(.white)
                                
                            }
                        }
                    }
            }.background(.green.opacity(0.7))
            //.navigationTitle("Add Ingredients")
            
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        // delete the objects here
        recipesVM.ingredientsSearched.remove(atOffsets: offsets)
    }
}

struct IngredientInput_Previews: PreviewProvider {
    static var previews: some View {
        IngredientInput().environmentObject(RecipesViewModel())
    }
}
