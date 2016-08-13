import Foundation
import Alamofire
import SwiftyJSON

class RequestManager {
    
    var searchResults = [JSON]()
    var overview = [JSON]()
    
    func search(searchText: String) {
        let headers = [
            "Content-Type":"application/json",
            "trakt-api-version":"2",
            "trakt-api-key":"c1044fe1db036f0bb7b548e6ff2f3afe9f65337ed25bf323865724830104e56a",
            ]
        Alamofire.request(.GET,"https://api.trakt.tv/search/movie?query="+searchText+"&extended=full,images",headers: headers).responseJSON {
            response in
            if let Json = response.result.value {
                for i in 0..<Json.count{
                    let items = JSON(Json[i])
                    self.searchResults .append(items)
             let overviewResult=items["movie"]["ids"]["slug"]
                    
                    let url = "https://api.trakt.tv/movies/"+overviewResult.stringValue+"/translations/es"
                    
                    Alamofire.request(.GET,url,headers: headers).responseJSON {
                        respons in
                        if let JsonOverview = respons.result.value {
                            let item_overview=JSON(JsonOverview)[0]
                            self.overview.append(item_overview)
NSNotificationCenter.defaultCenter().postNotificationName("searchResultsUpdated", object: nil)
                            }
                        
 
                    }
                    
                    
                    }
                    
                     }
                
        }
        
    }
    
    func resetSearch() {
        searchResults = []
        overview=[]
    }
    
}