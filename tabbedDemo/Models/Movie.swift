import Foundation

struct Movie: Equatable
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
    
    // var genre : String?
    
}

func ==(lhs: Movie, rhs: Movie) -> Bool
{
    
    return lhs.title == rhs.title
        && lhs.year == rhs.year
        && lhs.overView == rhs.overView
        && lhs.Realase == rhs.Realase
        && lhs.certification == rhs.certification
        && lhs.Rate == rhs.Rate
        && lhs.Vote == rhs.Vote
}
