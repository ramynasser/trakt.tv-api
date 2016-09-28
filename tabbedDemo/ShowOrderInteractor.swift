
import UIKit

protocol ShowMovieInteractorInput
{
  func getMovie(request: ShowMovie.GetMovie.Request)
  var order: Movie! { get set }
}

protocol ShowMovieInteractorOutput
{
  func presentMovie(response: ShowMovie.GetMovie.Response)
}

class ShowOrderInteractor: ShowMovieInteractorInput
{
  var output: ShowMovieInteractorOutput!
  var worker: ShowOrderWorker!
  
  var order: Movie!
  
  // MARK: Business logic
  
  func getMovie(request: ShowMovie.GetMovie.Request)
  {
    let response = ShowMovie.GetMovie.Response(order: order)
    output.presentMovie(response)
  }
}
