
import UIKit

protocol ShowMovieViewControllerInput
{
  func displayMovie(viewModel: ShowMovie.GetMovie.ViewModel)
}

protocol ShowMovieViewControllerOutput
{
  func getMovie(request: ShowMovie.GetMovie.Request)
  var order: Movie! { get set }
}

class ShowOrderViewController: UIViewController, ShowMovieViewControllerInput
{
    
    // show the details window
    var output: ShowMovieViewControllerOutput!
  var router: ShowOrderRouter!
    
    @IBOutlet weak var genreDetailLabel: UILabel!
    
    @IBOutlet weak var TitleDetailsLabel: UILabel!
    
    @IBOutlet weak var certificatDetailLabel: UILabel!
    @IBOutlet weak var RateDetailLabel: UILabel!
    @IBOutlet weak var VoteDetailLabel: UILabel!
    @IBAction func goToWebsite(sender: AnyObject) {
        
        
        UIApplication.sharedApplication().openURL(output.order.webSiteURL!)
        
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var ReleaseDetailLabel: UILabel!
    @IBOutlet weak var OverViewDetailLabel: UILabel!
    @IBOutlet weak var YearDetailLabel: UILabel!
    
    
    @IBAction func WatchTailerVideo(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(output.order.tailer_URL!)
        
        
    }

  
  // MARK: Object lifecycle
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    ShowOrderConfigurator.sharedInstance.configure(self)
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    getOrderOnLoad()
  }
  
  // MARK: Event handling
  
  func getOrderOnLoad()
  {
    // NOTE: Ask the Interactor to do some work
    
    let request = ShowMovie.GetMovie.Request()
    output.getMovie(request)
  }
  
  // MARK: Display logic
  
  func displayMovie(viewModel: ShowMovie.GetMovie.ViewModel)
  {
    let displayedMovie = viewModel.displayedMovie
    TitleDetailsLabel.text=displayedMovie.title
    TitleDetailsLabel.sizeToFit()
    OverViewDetailLabel.text=displayedMovie.overView
    YearDetailLabel.text=String(displayedMovie.year!)
    image.af_setImageWithURL(displayedMovie.imagesURL!)
    ReleaseDetailLabel.text =
    displayedMovie.Realase
    certificatDetailLabel.text=displayedMovie.Realase
    RateDetailLabel.text="Rate: "+String(displayedMovie.Rate!)
    VoteDetailLabel.text="Vote: "+String(displayedMovie.Vote!)
    // genreDetailLabel.text=genre
    
  }
}
