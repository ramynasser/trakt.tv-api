
import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class FirstViewController: UITableViewController{
    var titleArray=[String]()
    var yearArray=[Int]()
    var overViewArray=[String]()
    var imagesArray_url=[NSURL]()
    
    
    
    @IBOutlet  var tb1JSON: UITableView!
    var isNewDataLoading=false
    var item = 10
    var numberofRow=0
    override func viewDidLoad() {
        super.viewDidLoad()
        makejsonRequest()
        //self.tableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        
            
    
       self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor=UIColor.lightGrayColor()
        UITabBar.appearance().barTintColor = UIColor.darkGrayColor()
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == tableView{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if !isNewDataLoading{
                    
                       item=item+10
                        titleArray=[]
                        yearArray=[]
                        overViewArray=[]
                        imagesArray_url=[]
                        RequestPaginatation(1, item: item)
                        isNewDataLoading = true
                    
                   
                }
                isNewDataLoading=false
            }
        }
    }

    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor=UIColor.lightGrayColor()
        
    
    
    }
 
    func makejsonRequest(){
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
                    self.titleArray.append(title)
                    self.yearArray.append(year)
                    self.overViewArray.append(overview)
                    
                     let images = JSON_flag[i]["images"] as? [String: AnyObject]
                     let posters = images!["poster"] as? [String: AnyObject]
                     let mediumPoster = posters!["thumb"] as? String
                     let mediumPosterURL = NSURL(string: mediumPoster!)
                     self.imagesArray_url.append(mediumPosterURL!)
                     
 
                }
            }
           else {
            
            print("error")
            }
            if self.titleArray.count > 0 {
            self.tb1JSON.reloadData()
                
            }
        }
        
    }
    
    //make request for image 
    
  
    
    func RequestPaginatation(page:Int ,item:Int){
        //for download more movie if te user scroll down
        let headers = [
            "Content-Type":"application/json",
            "trakt-api-version":"2",
            "trakt-api-key":"c1044fe1db036f0bb7b548e6ff2f3afe9f65337ed25bf323865724830104e56a",
            ]
        Alamofire.request(.GET, "https://api.trakt.tv/movies/popular?page="+String(page)+"&limit="+String(item)+"&extended=full,images",  headers: headers).responseJSON { response in
            
            
            if let JSON_flag = response.result.value {
                self.numberofRow=JSON_flag.count
                print("number of utem of paging : \(self.numberofRow)")
                for i in 0..<JSON_flag.count{
                    
                    let title=JSON_flag[i]["title"] as! String
                    
                    let year=JSON_flag[i]["year"] as! Int
                    let overview=JSON_flag[i]["overview"] as! String
                    self.titleArray.append(title)
                    self.yearArray.append(year)
                    self.overViewArray.append(overview)
                    
                    let images = JSON_flag[i]["images"] as? [String: AnyObject]
                    let posters = images!["poster"] as? [String: AnyObject]
                    let mediumPoster = posters!["thumb"] as? String
                    let mediumPosterURL = NSURL(string: mediumPoster!)
                    self.imagesArray_url.append(mediumPosterURL!)
                }
            }
            else{
                
                print("error")
            }
            if self.titleArray.count > 0 {
                self.tb1JSON.reloadData()
            }
        }
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCellWithIdentifier("cell",forIndexPath:indexPath ) as! CustomViewCell
        
        
        
        if titleArray.count != 0{
            cell.title_details_Label.textAlignment = .Left
            cell.yeardetailLabel.textAlignment = .Left
            cell.overview_details_label.textAlignment = .Left
                
                
            cell.title_details_Label.text = self.titleArray[indexPath.row]
            let myString = String(self.yearArray[indexPath.row])
            cell.yeardetailLabel.text=myString
            cell.overview_details_label.text=self.overViewArray[indexPath.row]
            dispatch_async(dispatch_get_main_queue(), {
                cell.imageView?.af_setImageWithURL(self.imagesArray_url[indexPath.row])

            })
        }
        else{
            cell.yeardetailLabel.text="NO"
        
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor=UIColor.lightGrayColor()
        cell.backgroundColor = UIColor.blackColor()
        
        
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor=UIColor.lightGrayColor()
        return titleArray.count
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
 
    }
 
 
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor=UIColor.lightGrayColor()
        return     1

    }


}

