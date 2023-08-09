//
//  RecipeModel.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 3/13/23.
//

import Foundation
import SwiftUI

enum Category: String, Identifiable{
    
    var id: Self{
        return self
    }
    
    case breakfast = "Breakfast"
    case soup = "Soup"
    case appetizer = "Appetizer"
    case salad = "Salad"
    case main = "Main"
    case side = "Side"
    case snack = "Snack"
    case drink = "Drink"
    case dessert = "Dessert"
}

struct Recipe: Identifiable{
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let ingredients: String
    let directions: String
    let category: Category.RawValue
    let datePublished: String
    let url: String
    
    /*
     let cookTime: int
     let cookingLevel: String
     let restrictions: String
     let like: bool
     let star: bool
     */
}
extension Category: CaseIterable{}

extension Recipe {
    static let all: [Recipe] = [
    Recipe(name: "Multiple Vegetables",
           image: "https://cdn.pixabay.com/photo/2015/05/04/10/16/vegetables-752153__480.jpg", description: "iudhwieudfhieuhdfiuewf ofihjeiofjewoaijf", ingredients: "apples,blueberries,bread,eggs", directions: "diugw2hiuiuwhd iudhwiuqhd", category: "Soup", datePublished: "2019-10-22", url: "uwdgwhdiuwhdiuqwh"),
    Recipe(name: "Chocolate Pudding",
    image: "https://www.google.com/search?q=food&sxsrf=AJOqlzVAvfzoTNIbhfHNojlFTxG7zvDUQg:1678741920853&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjeovL-6Nn9AhWCl2oFHb00Bp0Q_AUoAXoECAEQAw&biw=1440&bih=741&dpr=2#imgrc=rMZ8I5b2kc3W3M",
    description: "ugehfuhe3fiduhewiuwefh uwefh fiu wehfiuewhfiuwe f", ingredients: "apples,blueberries,bread,eggs", directions: "diugw2hiuiuwhd iudhwiuqhd", category: "Side", datePublished: "2019-10-25", url: "uwdgwhdiuwhdiuqwh"),
    Recipe(name: "Banana Bread",
    image: "https://www.google.com/search?q=food&sxsrf=AJOqlzVAvfzoTNIbhfHNojlFTxG7zvDUQg:1678741920853&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjeovL-6Nn9AhWCl2oFHb00Bp0Q_AUoAXoECAEQAw&biw=1440&bih=741&dpr=2#imgrc=rMZ8I5b2kc3W3M",
    description: "ugehfuhe3fiduhewiuwefh uwefh fiu wehfiuewhfiuwe f", ingredients: "apples,blueberries,bread,eggs", directions: "diugw2hiuiuwhd iudhwiuqhd", category: "Dessert", datePublished: "2019-10-23", url: "uwdgwhdiuwhdiuqwh"),
    Recipe(name: "Scrambled Eggs",
    image: "https://www.google.com/search?q=food&sxsrf=AJOqlzVAvfzoTNIbhfHNojlFTxG7zvDUQg:1678741920853&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjeovL-6Nn9AhWCl2oFHb00Bp0Q_AUoAXoECAEQAw&biw=1440&bih=741&dpr=2#imgrc=rMZ8I5b2kc3W3M",
    description: "ugehfuhe3fiduhewiuwefh uwefh fiu wehfiuewhfiuwe f", ingredients: "apples,blueberries,bread,eggs", directions: "diugw2hiuiuwhd iudhwiuqhd", category: "Soup", datePublished: "2020-10-24", url: "uwdgwhdiuwhdiuqwh"),
    Recipe(name: "Caramel Chocolate",
    image: "https://www.google.com/search?q=food&sxsrf=AJOqlzVAvfzoTNIbhfHNojlFTxG7zvDUQg:1678741920853&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjeovL-6Nn9AhWCl2oFHb00Bp0Q_AUoAXoECAEQAw&biw=1440&bih=741&dpr=2#imgrc=rMZ8I5b2kc3W3M",
    description: "ugehfuhe3fiduhewiuwefh uwefh fiu wehfiuewhfiuwe f", ingredients: "apples,blueberries,bread,eggs", directions: "diugw2hiuiuwhd iudhwiuqhd", category: "Drink", datePublished: "2019-10-26", url: "uwdgwhdiuwhdiuqwh")
    
    ]
}
