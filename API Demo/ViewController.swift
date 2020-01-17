//
//  ViewController.swift
//  API Demo
//
//  Created by Rizul goyal on 2020-01-17.
//  Copyright © 2020 Rizul goyal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var cityLabel: UITextField!
    
    
    @IBAction func selectCity(_ sender: UIButton) {
        
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityLabel.text!.replacingOccurrences(of: " ", with: "%20"))&appid=7a293fa3d1fda49318a6844883e9557f")!
               let task = URLSession.shared.dataTask(with: url){
                   (data,response, error) in
                   if let error = error
                   {
                       print(error)
                   }
                   else
                   {
                       if let urlcontent = data{
                           do {
                               let jsonresult = try JSONSerialization.jsonObject(with: urlcontent, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                               print(jsonresult!)
                               print(jsonresult!["name"] as! String)
                            let name = jsonresult!["name"] as! String
                            
                               if let weather = ((jsonresult!["weather"] as! NSArray)[0] as? NSDictionary)?["description"] as? String
                               {
                                   print(weather)
                                DispatchQueue.main.async {
                                    self.infoLabel.text = name + weather

                                }
                               }
                               if let wind = (jsonresult!["wind"] as!  NSDictionary)["deg"] as? Int
                                                      {
                                                          print(wind)
                                                      }

                           }catch
                           {
                               print(error)
                           }
                       }
                   }
               }
               
               task.resume()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
           }
    


}

