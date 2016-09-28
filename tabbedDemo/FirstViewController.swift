
import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class FirstViewController: UITableViewController{
    var titleArray=[String]()
    var yearArray=[Int]()
    var overViewArray=[String]()
    var imagesArray_url=[NSURL]()
    var webSite_URL=[NSURL]()
    var RealaseArray=[String]()
    var RateArray=[Float]()
    var VoteArray=[Int]()
    var tailer_URL=[NSURL]()
    var certification=[String]()
    var genre_string:String!
    var flag:Int!
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
                        webSite_URL=[]
                       RealaseArray=[]
                        RateArray=[]
                       VoteArray=[]
                     tailer_URL=[]
                     certification=[]
                    
                        RequestPaginatation(1, item: item)
                        isNewDataLoading = true
                    
                   
                }
                isNewDataLoading=false
            }
        }
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
                    
                     print("\(s)")
                    self.genre_string=s
                    self.certification.append(certificate)
                    self.RateArray.append(rate)
                    self.VoteArray.append(vote)
                    self.titleArray.append(title)
                    self.yearArray.append(year)
                    self.overViewArray.append(overview)
                    self.RealaseArray.append(realase)
                    self.imagesArray_url.append(mediumPosterURL!)

                    if let website=JSON_flag[i]["homepage"] as? String {
                        self.webSite_URL.append(NSURL(string: website)!)
                        
                    }
                    else{
                        self.webSite_URL.append(NSURL(string:"https://www.google.com.eg/")!)
                        
                    }
                    
                    
                    if let video_url=JSON_flag[i]["trailer"] as? String {
                        self.tailer_URL.append(NSURL(string: video_url)!)
                        
                    }
                    else{
                        self.webSite_URL.append(NSURL(string:"https://www.youtube.com/")!)
                        
                    }
                    
                    
                    
                    
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
                print("number of items of paging : \(self.numberofRow)")
                for i in 0..<JSON_flag.count{

                    let title=JSON_flag[i]["title"] as! String
                    let year=JSON_flag[i]["year"] as! Int
                    let overview=JSON_flag[i]["overview"] as! String
                    if let website=JSON_flag[i]["homepage"] as? String {
                        self.webSite_URL.append(NSURL(string: website)!)

                    }
                    else{
                        self.webSite_URL.append(NSURL(string:"https://www.google.com.eg/")!)

                    }
                    

                   if let video_url=JSON_flag[i]["trailer"] as? String {
                        self.tailer_URL.append(NSURL(string: video_url)!)
                        
                    }
                    else{
                        self.webSite_URL.append(NSURL(string:"https://www.youtube.com/")!)
                        
                    }
                    
                    
                    if let certificate = JSON_flag[i]["certification"] as? String{
                        self.certification.append(certificate)

                    }
                    else{
                        self.certification.append("")

                    }
                    if let rate=JSON_flag[i]["rating"] as? Float{
                        self.RateArray.append(rate)

                    }
                    else{
                    self.RateArray.append(0.0)
                    }
                    if let vote=JSON_flag[i]["votes"] as? Int{

                    self.VoteArray.append(vote)
                    }
                    else{
                    self.VoteArray.append(0)
                    }
                    
                    let realase = JSON_flag[i]["released"] as! String
                    
                    let images = JSON_flag[i]["images"] as? [String: AnyObject]
                    let posters = images!["poster"] as? [String: AnyObject]
                    let mediumPoster = posters!["thumb"] as? String
                    let mediumPosterURL = NSURL(string: mediumPoster!)
                    let genre=JSON_flag[i]["genres"] as! NSArray
                    var s:String = ""
                    for j in 0..<genre.count{
 
                      s+=genre[j] as! String
                        s+="،،"

                    }
                    self.genre_string=s
                    self.RealaseArray.append(realase)
                    
                    
                    self.titleArray.append(title)
                    self.yearArray.append(year)
                    self.overViewArray.append(overview)
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
        
     //   tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let indexPath = tableView.indexPathForSelectedRow!
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let destination = storyboard.instantiateViewControllerWithIdentifier("detailsView") as! ThirdViewController
       // navigationController?.pushViewController(destination, animated: true)
        performSegueWithIdentifier("segue", sender:self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let backItem = UIBarButtonItem()
        backItem.title = "back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed      
        if let cell = sender as? CustomViewCell {
        let flag = self.tableView.indexPathForCell(cell)!.row
 
        if segue.identifier == "segue" {
            let detailScene=segue.destinationViewController as! ThirdViewController
           // detailScene.TitleDetailsLabel.text=titleArray[flag]
            detailScene.title_name=titleArray[flag]
            detailScene.year_name=yearArray[flag]
            detailScene.overview_name = overViewArray[flag]
            detailScene.image_url=self.imagesArray_url[flag]
            detailScene.website_url=self.webSite_URL[flag]
            detailScene.certification=self.certification[flag]
            detailScene.Rate=self.RateArray[flag]
            detailScene.Vote=self.VoteArray[flag]
            detailScene.tailer=self.tailer_URL[flag]
            detailScene.release_name=self.RealaseArray[flag]
            detailScene.genre=genre_string
        }
    }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCellWithIdentifier("cell",forIndexPath:indexPath ) as! CustomViewCell
        
        
        
        if titleArray.count != 0{
            cell.title_details_Label.textAlignment = .Left
            cell.yeardetailLabel.textAlignment = .Left
            cell.overview_details_label.textAlignment = .Left
            cell.overview_details_label.sizeToFit()
                
            cell.title_details_Label.text = self.titleArray[indexPath.row]
            cell.title_details_Label.sizeToFit()
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
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor=UIColor.lightGrayColor()
        
        
        
    }
 
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor=UIColor.lightGrayColor()
        return     1
        
    }
 
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}

