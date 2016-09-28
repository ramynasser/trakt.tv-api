//
//  ThirdViewController.swift
//  tabbedDemo
//
//  Created by Mohamed Farouk Code95 on 8/15/16.
//  Copyright © 2016 Mohamed Farouk Code95. All rights reserved.
//

import UIKit
import AlamofireImage

class ThirdViewController: UIViewController {
    
    
    
    @IBOutlet weak var genreDetailLabel: UILabel!
    
    var title_name: String?
    var year_name: Int?
    var release_name: String?
    var image_url:NSURL?
    var website_url:NSURL?
    var overview_name: String?
    var Rate:Float?
    var Vote:Int?
    var tailer:NSURL?
    var certification:String?
    var genre:String?

    
    @IBOutlet weak var TitleDetailsLabel: UILabel!

    @IBOutlet weak var certificatDetailLabel: UILabel!
    @IBOutlet weak var RateDetailLabel: UILabel!
    @IBOutlet weak var VoteDetailLabel: UILabel!
    @IBAction func goToWebsite(sender: AnyObject) {

   
UIApplication.sharedApplication().openURL(website_url!)
        
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var ReleaseDetailLabel: UILabel!
    @IBOutlet weak var OverViewDetailLabel: UILabel!
    @IBOutlet weak var YearDetailLabel: UILabel!
    
    
    @IBAction func WatchTailerVideo(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(tailer!)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleDetailsLabel.text=title_name
        TitleDetailsLabel.sizeToFit()
        OverViewDetailLabel.text=overview_name
        YearDetailLabel.text=String(year_name!)
        image.af_setImageWithURL(image_url!)
        ReleaseDetailLabel.text =
        release_name
        certificatDetailLabel.text=certification
        RateDetailLabel.text="Rate: "+String(Rate!)
        VoteDetailLabel.text="Vote: "+String(Vote!)
       // genreDetailLabel.text=genre
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
