

import UIKit
import Alamofire
import SwiftyJSON

class SecondViewController: UITableViewController{
    @IBOutlet var b2JSON: UITableView!
    
let searchController = UISearchController(searchResultsController: nil)
    var searchResults = [JSON]() {
        didSet {
            tableView.reloadData()
        }
    }
    var overviewResults = [JSON]()
    let requestManager = RequestManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Enter keyword..."
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SecondViewController.updateSearchResults), name: "searchResultsUpdated", object: nil)
    }
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    func updateSearchResults() {
        searchResults = requestManager.searchResults
        overviewResults=requestManager.overview
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return searchResults.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = self.b2JSON.dequeueReusableCellWithIdentifier("searchcell", forIndexPath: indexPath)  as! TableViewCell
        
        
       
        cell.titlLabel.text = searchResults[indexPath.section]["movie"]["title"].stringValue
        if String(searchResults[indexPath.section]["movie"]["year"]).containsString("null"){
        cell.YearLabel.text = "No Year "
        }
        else{
        cell.YearLabel.text = String(searchResults[indexPath.section]["movie"]["year"])
        }
        

        if  overviewResults.count <= indexPath.section{
            print("no overview for this movie")
            cell.overViewLabel.text = "no overview for this movie"
        }
        else{
            cell.overViewLabel.text = overviewResults[indexPath.section]["overview"].stringValue
            print("\(overviewResults[indexPath.section]["overview"].stringValue)")
 
        }
  
        
        
        cell.backgroundColor = UIColor.cyanColor()
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 4
        cell.clipsToBounds = true
        return cell
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    /*
    func search(query:String )->([JSON]){
    //for download more movie if te user scroll down
    let headers = [
        "Content-Type":"application/json",
        "trakt-api-version":"2",
        "trakt-api-key":"c1044fe1db036f0bb7b548e6ff2f3afe9f65337ed25bf323865724830104e56a",
        ]
    Alamofire.request(.GET,"https://api.trakt.tv/search/movie?query="+query,  headers: headers).responseJSON { response in
        
        if let Json = response.result.value {
            var countttt=Json.count
            for i in 0..<Json.count{
                let title=Json[i]["title"] as! String
                let year=Json[i]["year"] as! Int
                self.filtered.append(Json[i])
                print(title)
                
                
            }
        }
        else{
            
            print("error")
        }
        
    }
    
    }
  

*/
}

    extension SecondViewController: UISearchBarDelegate {
        func searchBarSearchButtonClicked(searchBar: UISearchBar) {
            
            requestManager.resetSearch()
            updateSearchResults()
            requestManager.search(searchBar.text!)
        }
}

