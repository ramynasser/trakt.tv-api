

import UIKit

protocol ListMoviesViewControllerInput
{
  func displayFetchedMovies(viewModel: ListMovies.FetchMovies.ViewModel)
}

protocol ListMoviesViewControllerOutput
{
  func fetchMovies(request: ListMovies.FetchMovies.Request)
 func fetchMoviesForpagination(request: ListMovies.FetchMovies.RequestPagination )
  
  var orders: [Movie]? { get }
  
    
}

class ListOrdersViewController: UITableViewController, ListMoviesViewControllerInput
{
    //for show the most 10 popular movie and make pagination
  var output: ListMoviesViewControllerOutput!
  @IBOutlet var tb1Json: UITableView!
  var router: ListOrdersRouter!
    var isNewDataLoading=false
    var item = 10
  var displayedMovies: [ListMovies.FetchMovies.ViewModel.DisplayedMovie] = []
    
  
  // MARK: Object lifecycle
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    ListOrdersConfigurator.sharedInstance.configure(self)
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    print("viewDidLoad")
    fetchOrdersOnLoad()
  }
  
  // MARK: Event handling
  
  func fetchOrdersOnLoad()
  {
    let request = ListMovies.FetchMovies.Request()
    print ("send request to interactor")
    output.fetchMovies(request)
  }
    
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == tableView{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if !isNewDataLoading{
                    
                    item=item+10
                    displayedMovies = []
                    
                    let request = ListMovies.FetchMovies.RequestPagination(page: 1, limit: item)
                    print ("send request to interactor")
                    output.fetchMoviesForpagination(request)
                    isNewDataLoading = true
                    
                    
                }
                isNewDataLoading=false
            }
        }
    }

  
  // MARK: Display logic
  
  func displayFetchedMovies(viewModel: ListMovies.FetchMovies.ViewModel)
  {
    print("i will print the result")
    displayedMovies = viewModel.displayedMovies
    print("\(displayedMovies.count)")

    tb1Json.reloadData()
  }
  
  // MARK: Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return displayedMovies.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let displayedOrder = displayedMovies[indexPath.row]
    let cell=tableView.dequeueReusableCellWithIdentifier("cell" ) as! CustomViewCell

    
    if displayedMovies.count != 0{
        cell.title_details_Label.textAlignment = .Left
        cell.yeardetailLabel.textAlignment = .Left
        cell.overview_details_label.textAlignment = .Left
        cell.overview_details_label.sizeToFit()
        cell.title_details_Label.text = displayedOrder.title
        cell.title_details_Label.sizeToFit()
        let myString = String(displayedOrder.year)
        cell.yeardetailLabel.text=myString
        cell.overview_details_label.text=displayedOrder.overView
        cell.imageView?.af_setImageWithURL(displayedOrder.imagesURL!)
       
    }
    else {
    cell.yeardetailLabel.text="NO"
    
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    tableView.separatorColor=UIColor.lightGrayColor()
    cell.backgroundColor = UIColor.blackColor()
    return cell
  }
}
