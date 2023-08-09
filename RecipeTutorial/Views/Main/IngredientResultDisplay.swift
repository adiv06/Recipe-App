//
//  IngredientResultDisplay.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 6/21/23.
//

import SwiftUI

struct IngredientResultDisplay: View{
    @EnvironmentObject var recipesVM: RecipesViewModel
    @State var addIngredient: Bool = false
    @State static var infoAvailable: Bool = false
    @State var cameraViewPresenting: Bool = false
    @State var testCamera: TestImage = TestImage()
    
    let tap = UITapGestureRecognizer(target: TestImage.self, action: #selector(TestImage.handleTap(_:)))
    
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10){
                        ForEach(recipesVM.ingredientsSearched, id: \.self){ ingredient in
                            HStack{
                                Text("\(ingredient)")
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .frame(maxHeight: 40)
                                
                                Button() {
                                    recipesVM.removeIngredient(ingredient: ingredient)
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                
                            }.background(
                                .green)
                            .cornerRadius(10)
                        }
                    Button {
                        addIngredient.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.black)
                        .frame(maxWidth: 40)
                    }.sheet(isPresented: $addIngredient) {
                        IngredientInput()
                    }

                    
                        
                    }.padding()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity)
                                 
                LazyVStack{
                    
                    HStack {
                        //Tried to make it look a little prettier
                        
                        Text("**Want to search faster? Try the camera feature.**")
                            .padding()
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            //.bold()
                            .background(LinearGradient(gradient: Gradient(colors: [Color(.blue).opacity(0.8), Color((.purple))]), startPoint: .topLeading, endPoint: .bottom))
                            .border(.black, width: 3)
                            .cornerRadius(10)

                        Spacer()
                        Button(){
                            cameraViewPresenting = true
                            //TestImage.cameraButtonTap(testCamera)
                        }label:{
                            Image(systemName: "camera.viewfinder")
                                .resizable()
                                .foregroundColor(.black)
                                .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 65)
                        }
                            //.addGestureRecognizer(tap)
                            //IngredientResultDisplay.addGestureRecognizer(tap)
                        
                                            }
                    .sheet(isPresented: $cameraViewPresenting) {
                        newImageView()
                    }
                    
                    Button {
                        // Make API Call and search
                        recipesVM.searchByIngredients()
                    } label: {
                        Text("Search")
                            .foregroundColor(.primary)
                            .bold()
                            .frame(maxWidth: UIScreen.main.bounds.width)
                            .padding()
                            .background(.gray.opacity(0.4))
                            .padding(.vertical, 5)
                            
                    }.border(.black, width: 4)
                        .cornerRadius(10)
                    //Data for when there is none from API to fill screen
                    
                    //Check if there is data before you display
                    if(recipesVM.extraIngredientResultInfo.count == recipesVM.ingredientSearchRecipeID.count || recipesVM.ingredientSearchRecipeID.count == 0)
                    {
                        ForEach(recipesVM.ingredientResults){ingredient in
                            NavigationLink(destination: IngredientRecipeView(recipe: recipesVM.extraIngredientResultInfo.first(where: { recipeInfo in
                                recipeInfo.id == ingredient.id
                            }) ?? recipesVM.extraIngredientResultInfo[0]/*Will change from force unwrapping to some alert later if no ID is found*/))
                            {
                                IngredientResultCard(ingredientInfo: ingredient)
                            }
                        }
                    }else{
                        ProgressView()
                            .padding(.vertical, 40)
                    }

                    
                }
                .padding(.horizontal)

            }
            .navigationTitle("Ingredient Search")
            
        }
    }
}
/*
extension UIView{
    func addTapGesture(action : @escaping() -> Void){
        let tap = MyTapGestureRecognizer(target: TestImage.self, action: #selector(TestImage.handleTap(_:)))
        tap.action = action
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc func handleTap(_ sender: MyTapGestureRecognizer){
        sender.action!()
    }
        
}

class MyTapGestureRecognizer: UITapGestureRecognizer{
    var action : (()->Void)? = nil
}
*/
struct IngredientResultDisplay_Previews: PreviewProvider {
    static var previews: some View {
        IngredientResultDisplay()
            .environmentObject(RecipesViewModel())
    }
}
