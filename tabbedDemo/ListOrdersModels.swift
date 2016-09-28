

import UIKit

struct ListMovies
{
  struct FetchMovies
  {
    struct Request
    {
    }
    
    struct RequestPagination
    {
        var page:Int?
        var limit:Int?
        
    }
    
    struct Response
    {
      var Movies: [Movie]
    }
    struct ViewModel
    {
      struct DisplayedMovie
      {
        var title: String?
        var year : Int?
        var imagesURL: NSURL?
        var webSiteURL : NSURL?
        var tailer_URL : NSURL?
        var overView: String?
        var Realase: String?
        var certification: String?
        var Rate: Float?
        var Vote: Int?
      }
      var displayedMovies: [DisplayedMovie]
    }
  }
}
