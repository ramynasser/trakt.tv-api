

import UIKit

protocol ShowMoviePresenterInput
{
  func presentMovie(response: ShowMovie.GetMovie.Response)
}

protocol ShowMoviePresenterOutput: class
{
  func displayMovie(viewModel: ShowMovie.GetMovie.ViewModel)
}

class ShowOrderPresenter: ShowMoviePresenterInput
{
  weak var output: ShowMoviePresenterOutput!
  
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
  
  func presentMovie(response: ShowMovie.GetMovie.Response)
  {
    let order = response.order
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
    let displayedMovie = ShowMovie.GetMovie.ViewModel.DisplayedMovie(title:title, year: year, imagesURL: image_url, webSiteURL: website_url, tailer_URL: tailer_url, overView: overview, Realase: realase, certification: certification, Rate: rate, Vote: vote)
    let viewModel = ShowMovie.GetMovie.ViewModel(displayedMovie: displayedMovie)
    output.displayMovie(viewModel)
  }
}
