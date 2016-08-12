
import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class FirstViewController: UITableViewController{
    var titleArray=[String]()
    var yearArray=[Int]()
    var overViewArray=[String]()
    var imagesResults=[UIImage]()
    @IBOutlet  var tb1JSON: UITableView!
    var isNewDataLoading=false
    var item = 10
    var numberofRow=0
    override func viewDidLoad() {
        super.viewDidLoad()
        makejsonRequest()
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
        Alamofire.request(.GET, "https://api.trakt.tv/movies/popular",  headers: headers).responseJSON { response in
        
            if let JSON_flag = response.result.value{
                
                self.numberofRow=JSON_flag.count
                for i in 0..<self.numberofRow{
                    let title=JSON_flag[i]["title"] as! String
                    
                    let year=JSON_flag[i]["year"] as! Int
                    
                    self.titleArray.append(title)
                    self.yearArray.append(year)
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
    
    
    func makeImageRequest(){
        let headers = [
            "Content-Type":"application/json",
            "trakt-api-version":"2",
            "trakt-api-key":"c1044fe1db036f0bb7b548e6ff2f3afe9f65337ed25bf323865724830104e56a",
            ]
        Alamofire.request(.GET, "https://api.trakt.tv/movies/popular?extended=full,images",  headers: headers).responseJSON { response in
            if response.result.isFailure{
                
                self.imagesResults.append(UIImage(named:"noposter")!)
            }
            else{
                
                
                if let JSON_flag = response.result.value{
                self.numberofRow=JSON_flag.count
                for i in 0..<self.numberofRow{
                    let images=JSON_flag[i]["images"] as! String
                    
                    if !images.isEmpty {
                
                        self.imagesResults.append(UIImage(named:images)!)
                    }
                    else{
                        self.imagesResults.append(UIImage(named:"noposter")!)
                    
                    }
                    
                    
                }
            }
           
            if self.titleArray.count > 0 {
                self.tb1JSON.reloadData()
                
            }
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
        Alamofire.request(.GET, "https://api.trakt.tv/movies/popular?page="+String(page)+"&limit="+String(item),  headers: headers).responseJSON { response in
            
            
            if let JSON_flag = response.result.value {
                self.numberofRow=JSON_flag.count
                print("number of utem of paging : \(self.numberofRow)")
                for i in 0..<JSON_flag.count{
                    let title=JSON_flag[i]["title"] as! String
                    let year=JSON_flag[i]["year"] as! Int
                    
                    
                    print(title)
                    //  print(year)
                    self.titleArray.append(title)
                    self.yearArray.append(year)
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
            cell.title_details_Label.text = self.titleArray[indexPath.section]
            let myString = String(self.yearArray[indexPath.section])
            cell.yeardetailLabel.text=myString
        }
        else{
            cell.yeardetailLabel.text="NO"
        
        }
        
        
        cell.backgroundColor = UIColor.cyanColor()
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 4
        cell.clipsToBounds = true
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        return     titleArray.count

    }


}

