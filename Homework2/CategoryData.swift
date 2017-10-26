//
//  CategoryData.swift
//  Homework2
//
//  Created by Gupta, Nidhi on 10/11/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import Foundation
class CategoryData : Codable{
    let categoryName : String
    let developerName : String
    let title : String
    let smallImage : String?
    let releaseDate : String
    let summary : String?
    let price : Double
    let largeImage : String?

    init(categoryName : String, title: String, developerName: String, releaseDate: String, price : Double, smallImage : String!, largeImage : String!, summary : String!) {
        self.categoryName = categoryName
        self.title = title
        self.developerName = developerName
        self.releaseDate = releaseDate
        self.price = price
        self.smallImage = smallImage!
        if(largeImage != nil)
        {self.largeImage = largeImage!}
        else {self.largeImage = nil}
        if(summary != nil){
             self.summary = summary!
        }
        else {
             self.summary = nil
        }
     }
}
/*class CategoryJSONData : Codable{
    let category : Category?
    let artist : StringValues?
    let name : StringValues?
    let releaseDate : StringValues?
    let price : DoubleValues?
    let squareImage : [StringValues?]
    let summary : StringValues?
    let otherImage : [StringValues?]
}
class Feed : Codable
{
    var feed : [CategoryJSONData]
    
    init(){
        feed = []
    }
}
class Category : Codable{
    var attributes : CategoryAttribute
}
class CategoryAttribute : Codable{
    var term : String
}
class StringValues : Codable{
    var label : String
}
class DoubleValues : Codable{
    var amount : Double
}*/
