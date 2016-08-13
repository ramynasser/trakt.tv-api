

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
        cell.overViewLabel.text = searchResults[indexPath.section]["movie"]["overview"].stringValue
        print("\(searchResults[indexPath.section]["movie"]["overview"].stringValue)")
        if String(searchResults[indexPath.section]["movie"]["year"]).containsString("null"){
        cell.YearLabel.text = "No Year "
        }
        else{
        cell.YearLabel.text = String(searchResults[indexPath.section]["movie"]["year"])
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
    
    
        
    }
    

  




    extension SecondViewController: UISearchBarDelegate {
        func searchBarSearchButtonClicked(searchBar: UISearchBar) {
            
            requestManager.resetSearch()
            updateSearchResults()
            requestManager.search(searchBar.text!)
        }
}

