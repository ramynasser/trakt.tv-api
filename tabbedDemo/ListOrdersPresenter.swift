

import UIKit

protocol ListMoviesPresenterInput
{
  func presentFetchedMovies(response: ListMovies.FetchMovies.Response)
}

protocol ListMoviesPresenterOutput: class
{
  func displayFetchedMovies(viewModel: ListMovies.FetchMovies.ViewModel)
}

class ListOrdersPresenter: ListMoviesPresenterInput
{
  weak var output: ListMoviesPresenterOutput!
  let dateFormatter: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = .ShortStyle
    dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
    return dateFormatter
  }()
  let currencyFormatter: NSNumberFormatter = {
    let currencyFormatter = NSNumberFormatter()
    currencyFormatter.numberStyle = .CurrencyStyle
    return currencyFormatter
  }()
  
  // MARK: Presentation logic
  
  func presentFetchedMovies(response: ListMovies.FetchMovies.Response)
  {
    var displayedOrders: [ListMovies.FetchMovies.ViewModel.DisplayedMovie] = []
    for order in response.Movies{

      let year = order.year
      let rate = order.Rate
      let vote = order.Vote
      let title = order.title
      let image_url = order.imagesURL
      let website_url = order.webSiteURL
      let tailer_url = order.tailer_URL
      let overview = order.overView
      let realase = order.Realase
      let certification = order.certification
        
        let displayedOrder = ListMovies.FetchMovies.ViewModel.DisplayedMovie(title:title, year: year, imagesURL: image_url, webSiteURL: website_url, tailer_URL: tailer_url, overView: overview, Realase: realase, certification: certification, Rate: rate, Vote: vote)
      displayedOrders.append(displayedOrder)
    }
    let viewModel = ListMovies.FetchMovies.ViewModel(displayedMovies: displayedOrders)
    output.displayFetchedMovies(viewModel)
  }
}
