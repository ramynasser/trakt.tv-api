import Foundation

import Alamofire
import SwiftyJSON
import AlamofireImage

class OrdersMemStore: OrdersStoreProtocol
{
    public var orders = [Movie]()
    
    
    
    var isNewDataLoading=false
    var item = 10
    var numberofRow=0
    
    
    
    // MARK: - CRUD operations - Optional error
    
    func fetchOrders(completionHandler: (orders: [Movie], error: OrdersStoreError?) -> Void)
    {
        completionHandler(orders: orders, error: nil)
    }
    
    
    // MARK: - CRUD operations - Generic enum result type
    
    func fetchOrders(completionHandler: OrdersStoreFetchOrdersCompletionHandler)
    {
        completionHandler(result: OrdersStoreResult.Success(result: orders))
    }
    
    
    
    // MARK: - CRUD operations - Inner closure
    
    func fetchOrders(completionHandler: (orders: () throws -> [Movie]) -> Void)
    {
        completionHandler {
            let headers = [
                "Content-Type":"application/json",
                "trakt-api-version":"2",
                "trakt-api-key":"c1044fe1db036f0bb7b548e6ff2f3afe9f65337ed25bf323865724830104e56a",
            ]
            Alamofire.request(.GET, "https://api.trakt.tv/movies/popular?extended=full,images",  headers: headers).responseJSON { response in
                
                if let JSON_flag = response.result.value{
                    
                    self.numberofRow=JSON_flag.count
                    for i in 0..<self.numberofRow{
                        let title=JSON_flag[i]["title"] as! String
                        let year=JSON_flag[i]["year"] as! Int
                        let overview=JSON_flag[i]["overview"] as! String
                        let rate=JSON_flag[i]["rating"] as! Float
                        let vote=JSON_flag[i]["votes"] as! Int
                        
                        let realase = JSON_flag[i]["released"] as! String
                        
                        let certificate = JSON_flag[i]["certification"] as! String
                        let images = JSON_flag[i]["images"] as? [String: AnyObject]
                        let posters = images!["poster"] as? [String: AnyObject]
                        let mediumPoster = posters!["thumb"] as? String
                        let mediumPosterURL = NSURL(string: mediumPoster!)
                        let genre=JSON_flag[i]["genres"] as! NSArray
                        var s:String = ""
                        for j in 0..<genre.count{
                            
                            s+=genre[j] as! String
                            s+="،،،،"
                        }
                        
                        var weburl:NSURL?
                        var tailerurl:NSURL?
                        
                        if let website=JSON_flag[i]["homepage"] as? String {
                            weburl = NSURL(string: website)
                            
                        }
                        else{
                            weburl = NSURL(string:"https://www.google.com.eg/")
                            
                        }
                        
                        
                        if let video_url=JSON_flag[i]["trailer"] as? String {
                            tailerurl = NSURL(string: video_url)
                            
                        }
                        else{
                            tailerurl = NSURL(string:"https://www.youtube.com/")
                            
                        }
                        let movie = Movie(title: title, year: year, imagesURL: mediumPosterURL, webSiteURL: weburl, tailer_URL: tailerurl, overView: overview, Realase: realase, certification: certificate, Rate: rate, Vote:vote )
                        
                        self.orders.append(movie)
                        
                    }
                }
                else {
                    
                    print("error")
                }
                
            }
            
            
            
            return self.orders
            
        }
    }
    
    
    
}
