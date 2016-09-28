

import UIKit

struct ShowMovie
{
  struct GetMovie
  {
    struct Request
    {
        
    }
    

    struct Response
    {
      var order: Movie
    }
    struct ViewModel
    {
      struct DisplayedMovie
      {var title: String?
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
      var displayedMovie: DisplayedMovie
    }
  }
}
