

import UIKit
import Alamofire
import SwiftyJSON

class SecondViewController: UITableViewController{
    @IBOutlet var b2JSON: UITableView!
    var isNewDataLoading=true
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
        
 
        definesPresentationContext = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SecondViewController.updateSearchResults), name: "searchResultsUpdated", object: nil)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor=UIColor.lightGrayColor()
        UITabBar.appearance().barTintColor = UIColor.darkGrayColor()
        if (self.tableView.contentSize.height < self.tableView.frame.size.height) {
            self.tableView.scrollEnabled = false;
            self.tableView.pagingEnabled=false
        }
        else {
            self.tableView.scrollEnabled = true;
            self.tableView.pagingEnabled=false
        }    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == tableView{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height){
            
                self.tableView.pagingEnabled=false
                }
            
            }
           
        }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor=UIColor.lightGrayColor()
        
        
        
    }
    
    
    
    
    func updateSearchResults() {
        searchResults = requestManager.searchResults
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor=UIColor.lightGrayColor()
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
        cell.YearLabel.text = ""
        }
        else{
        cell.YearLabel.text = String(searchResults[indexPath.section]["movie"]["year"])
        }
        
        
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        //tableView.separatorColor=UIColor.lightGrayColor()
        cell.backgroundColor = UIColor.whiteColor()
        //cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 2
        cell.clipsToBounds = true
        return cell
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
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

