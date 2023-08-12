//
//  RecipesViewModel.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 3/31/23.
//

import Foundation
import UIKit

class RecipesViewModel: ObservableObject{
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var recipeResults: [RecipeSearchResult] = []
    @Published var ingredientResults: [IngredientSearchResult] = []
    @Published private(set) var extraIngredientResultInfo: [RecipeInfo] = []
    @Published var ingredientsSearched: [String] = ["Apples", "Oranges", "Almonds", "Tostitos", "Lemon Zest"]
    @Published private(set) var ingredientSearchRecipeID: [Int] = []
    //Testing API Call Array
    @Published private(set) var extraIngredientResultInfoTest: [RecipeInfo] = []
    static var imageSearchPictures: [UIImage] = []
    static var showSettingsAlert: Bool = false
    
    let headers = [
        "x-api-key": "864aad78d8bc4a86be99da353c5bc43c",
        "x-api-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
        "Content-Type": "application/json"
    ]
    
    
    init(){
        recipes = Recipe.all
        recipeResults = RecipeSearchResult.test
        ingredientResults = IngredientSearchResult.ingredientTest
        extraIngredientResultInfo = RecipeInfo.recipeInfoTest
        
        //Populate recipe steps with test ingredients
        Step.testSteps.indices.forEach({ index in
            Step.testSteps[index].ingredients = Ingredient.testIngredients
        })
        
        //Populate recipe results with testSteps
        recipeResults.indices.forEach { index in
            recipeResults[index].analyzedInstructions = [AnalyzedInstruction(steps: Step.testSteps)]
        }
        
        extraIngredientResultInfo.indices.forEach { index in
            extraIngredientResultInfo[index].extendedIngredients = ExtendedIngredient.extendedIngredientTest
            extraIngredientResultInfo[index].analyzedInstructions = [AnalyzedInstruction(steps: Step.testSteps)]
        }
    }
    
    
    //Makes sure there are no duplicate ingredients, can use sets some other way
    func uniqueIngredients(){
        
        recipeResults.indices.forEach { index in
            var noDupeIngredients: Set<Ingredient> = []
            recipeResults[index].analyzedInstructions[0]?.steps?.forEach({ step in
                step.ingredients?.forEach({ ingredient in
                        noDupeIngredients.insert(ingredient)
                })
            })
            recipeResults[index].analyzedInstructions[0]?.steps?[0].ingredients = Array(noDupeIngredients)
        }
        
    }

    
    func addRecipe(recipe: Recipe){
        recipes.append(recipe)
    }
    
    func addSearchResult(recipeResult: RecipeSearchResult){
        recipeResults.append(recipeResult)
    }
    
    func addIngredient(ingredient: String){
        var newString: String = ""
        newString = ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
        if(newString != "" && newString.count > 2 && !ingredientsSearched.contains(newString))
        {
            ingredientsSearched.append(newString)
        }
    }
    
    func removeIngredient(ingredient: String){
        if(ingredientsSearched.contains(ingredient)){
            ingredientsSearched.remove(at: ingredientsSearched.firstIndex(of: ingredient)!)
        }
    }
    
    func recipeIDCollect(ingredientResults: [IngredientSearchResult]){
        self.ingredientSearchRecipeID.removeAll()
        for result in ingredientResults
        {
            ingredientSearchRecipeID.append(result.id)
        }
    }
    
    //MARK: Recipe Name + Info API Request
    func getRecipeSearchResults(query: String) -> Void {
        
            let url = NSMutableURLRequest(url: NSURL(string: "https://api.spoonacular.com/recipes/complexSearch?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? query)&addRecipeInformation=true&number=16")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        url.httpMethod = "GET"
        url.allHTTPHeaderFields = headers

        let task = URLSession.shared.dataTask(with: url as URLRequest, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching recipes: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
              print("Error with the response, unexpected status code: \(String(describing: response))")
            return
          }

            //var myDict = Dictionary<String, Any>()
          if let data2 = data,
             let searchResults = try? JSONDecoder().decode(ObjectResult.self, from: data2) {
              self.recipeResults = searchResults.results
              self.uniqueIngredients()
              APIDataSearchBar.loadResults = true
          }
        })
        task.resume()
      }
    
    //MARK: Ingredient API Request
    
    func searchByIngredients() -> Void{
        var queryString: String = ""
        ingredientsSearched.indices.forEach(){ x in
            if(x == ingredientsSearched.count - 1)
            {
                queryString.append(ingredientsSearched[x])
            }
            else {queryString.append(ingredientsSearched[x] + ",+")}
        }
        
        queryString = queryString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? queryString
        
        let url = NSMutableURLRequest(url: NSURL(string: "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(queryString)&number=5")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        
        
        
        url.httpMethod = "GET"
        url.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: url as URLRequest, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching recipes: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            //var myDict = Dictionary<String, Any>()
            if let data2 = data,
               let searchResults = try? JSONDecoder().decode([IngredientSearchResult].self, from: data2) {
                print(searchResults)
                DispatchQueue.main.async {
                    self.ingredientResults = searchResults
                    self.recipeIDCollect(ingredientResults: searchResults)
                    self.getExtraIngredientInfo()
                }
            }
        })
        task.resume()
    }
        
        //MARK: Recipe Info Bulk API Call
        func getExtraIngredientInfo() -> Void {
            var queryString: String  = ""
            
            ingredientSearchRecipeID.indices.forEach { index in
                if(index == ingredientSearchRecipeID.count - 1)
                {
                    queryString.append(String(ingredientSearchRecipeID[index]))
                } else{queryString.append(String(ingredientSearchRecipeID[index]) + ",")}
            }
            
            queryString = queryString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? queryString
            print("\n\n\(queryString)\n\n")
            
            let url = NSMutableURLRequest(url: NSURL(string: "https://api.spoonacular.com/recipes/informationBulk?ids=\(queryString)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            
            url.httpMethod = "GET"
            url.allHTTPHeaderFields = headers

            let task = URLSession.shared.dataTask(with: url as URLRequest, completionHandler: { (data, response, error) in
              if let error = error {
                print("Error with fetching recipes: \(error)")
                return
              }
              
              guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                  print("Error with the response, unexpected status code: \(String(describing: response))")
                return
              }

                //var myDict = Dictionary<String, Any>()
              if let data2 = data,
                 let searchResults = try? JSONDecoder().decode([RecipeInfo].self, from: data2) {
                  print(searchResults)
                  DispatchQueue.main.async {
                      self.extraIngredientResultInfo = searchResults
                  }
              }
            })
            task.resume()
          }
        
        //MARK: Test API Call
    /*
    func testIngredientInfo(testID: [Int]) -> Void {
            var queryString: String  = ""
            
            testID.indices.forEach { index in
            if(index == testID.count - 1)
            {
                queryString.append(String(testID[index]))
            } else{queryString.append(String(testID[index]) + ",")}
        }
            
            queryString = queryString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? queryString
            
            let url = NSMutableURLRequest(url: NSURL(string: "https://api.spoonacular.com/recipes/informationBulk?ids=\(queryString)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            
            url.httpMethod = "GET"
            url.allHTTPHeaderFields = headers

            let task = URLSession.shared.dataTask(with: url as URLRequest, completionHandler: { (data, response, error) in
              if let error = error {
                print("Error with fetching recipes: \(error)")
                return
              }
              
              guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                  print("Error with the response, unexpected status code: \(String(describing: response))")
                return
              }

                //var myDict = Dictionary<String, Any>()
              if let data2 = data,
                 let searchResults = try? JSONDecoder().decode([RecipeInfo].self, from: data2) {
                  print(searchResults)
                  DispatchQueue.main.async {
                      self.extraIngredientResultInfoTest = searchResults
                  }
              }
            })
            task.resume()
          }
     */

    }

