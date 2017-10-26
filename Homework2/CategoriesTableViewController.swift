//
//  CategoriesTableViewController.swift
//  Homework2
//
//  Created by Gupta, Nidhi on 10/11/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class CategoriesTableViewController: UITableViewController {

    var booksData = [CategoryData]()
    var applicationsData = [CategoryData]()
    var mySections = [SectionData]()
    
   class SectionData {
        let title: String
        let data : [CategoryData]
        init(title: String, data: [CategoryData]){
            self.title = title
            self.data = data
        }
    }
    override func awakeFromNib() {
        
         }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        GetAPIData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return mySections[section].data.count
     }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
         print(section)
         print(mySections[section].title)
        if(mySections[section].title == "")
        {  return "Empty"
            
        }
        return mySections[section].title
        
    }
     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
     return 250
     }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let row = mySections[indexPath.section].data[indexPath.item]
        var identifierName = ""
        if(row.summary != nil)
        {identifierName = "summaryCell"}
        else if(row.largeImage != nil)
        { identifierName = "imageCell"}
        else
        { identifierName = "basicCell"}
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierName, for: indexPath)
        
        if(identifierName == "summaryCell")
        {
            (cell as! SummaryTableViewCell).smallImageView.sd_setImage(with: URL(string : row.smallImage!), completed: nil)
             (cell as! SummaryTableViewCell).title.text = row.title
             (cell as! SummaryTableViewCell).developerName.text = row.developerName
             (cell as! SummaryTableViewCell).price.text = String(format: "$%.2f", row.price)
             (cell as! SummaryTableViewCell).realeaseDate.text = row.releaseDate
             (cell as! SummaryTableViewCell).summary.text = row.summary
        }
        else if(identifierName == "imageCell")
        {
            
            (cell as! ImageTableViewCell).smallImageView.sd_setImage(with: URL(string : row.smallImage!), completed: nil)
            (cell as! ImageTableViewCell).title.text = row.title
            (cell as! ImageTableViewCell).developerName.text = row.developerName
            (cell as! ImageTableViewCell).price.text = String(format: "$%.2f", row.price)
            (cell as! ImageTableViewCell).releaseDate.text = row.releaseDate
            (cell as! ImageTableViewCell).largeImageView.sd_setImage(with: URL(string : row.largeImage!), completed: nil)
        }
        else
        {
            (cell as! BasicTableViewCell).basicImageView.sd_setImage(with: URL(string : row.smallImage!), completed: nil)
             (cell as! BasicTableViewCell).appTitle.text = row.title
             (cell as! BasicTableViewCell).developerName.text = row.developerName
             (cell as! BasicTableViewCell).price.text = String(format: "$%.2f", row.price)
             (cell as! BasicTableViewCell).releaseDate.text = row.releaseDate
        }
        
        return cell
        
    }
    
   
    func GetAPIData() {
        let url = URL(string: "http://dev.theappsdr.com/apis/summer_2016_ios/data.json")
        Alamofire.request(url!)
            .responseJSON {response in
                
                guard response.result.error == nil else {
                   print(response.result.error!)
                    return
                }
                //response check
                guard let json = response.result.value as? [String: Any] else {
                    print("Error: \(response.result.error)")
                    return
                }
                //parse
                guard let categoriesData = json["feed"] as? [[String: Any]]  else {
                    print("no feed")
                    return
                }
                
                for feed in categoriesData{
                    
                    var categoryName = "", title = "", developerName = "", releaseDate = ""
                    var price:Double?
                    var smallImage:String! = nil, largeImage:String! = nil
                    var summary:String! = nil
                    
                    if let categoryData = feed["category"] as? [String:Any],
                        let attributes = categoryData["attributes"] as? [String:Any],
                        let term = attributes["term"] as? String{
                        categoryName = term
                    }
                    
                    if let name = feed["name"] as? [String:Any],
                        let label = name["label"] as? String{
                        title = label
                    }
                    if let artist = feed["artist"] as? [String:Any],
                        let label = artist["label"] as? String{
                        developerName = label
                    }
                    if let releaseDateDict = feed["releaseDate"] as? [String:Any],
                        let label = releaseDateDict["label"] as? String{
                        releaseDate = label
                    }
                    if let priceDict = feed["price"] as? [String:Any],
                        let amount = priceDict["amount"] as? Double{
                        price = amount
                    }
                    if let squareImage = feed["squareImage"] as? [Any],
                        let firstObject = squareImage[0] as? [String:Any],
                        let label = firstObject["label"] as? String{
                        smallImage = label
                    }
                    if let summaryDict = feed["summary"] as? [String:Any],
                        let label = summaryDict["label"] as? String{
                        summary = label
                    }
                    
                    //other image url
                    if let otherImageArray = feed["otherImage"] as? [Any],
                        let firstObject = otherImageArray[0] as? [String:Any],
                        let label = firstObject["label"] as? String{
                        largeImage = label
                    }
                    
                    let newItem = CategoryData(categoryName: categoryName, title: title, developerName: developerName,
                                               releaseDate: releaseDate, price: price!,
                                               smallImage: smallImage, largeImage: largeImage, summary: summary)
                    if(categoryName == "Books"){
                        self.booksData.append(newItem)
                    }
                    else if(categoryName == "Applications"){
                        self.applicationsData.append(newItem)
                    }
                    
                 }
                self.mySections = {
                    let section1 = SectionData(title: "Books", data: self.booksData)
                    let section2 = SectionData(title: "Applications", data: self.applicationsData)
                    
                    return [section1, section2]
                }()
                self.tableView.reloadData()
        }
    }
    

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
