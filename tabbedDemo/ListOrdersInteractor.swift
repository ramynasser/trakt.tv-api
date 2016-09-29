
import UIKit

import Alamofire
import SwiftyJSON
import AlamofireImage

protocol ListMoviesInteractorInput
{
    func fetchMovies(request: ListMovies.FetchMovies.Request)
    func fetchMoviesForpagination(request: ListMovies.FetchMovies.RequestPagination )


    var orders: [Movie]? { get }
}

protocol ListMoviesInteractorOutput
{
    func presentFetchedMovies(response: ListMovies.FetchMovies.Response)
}

class ListOrdersInteractor: ListMoviesInteractorInput
{
    var output: ListMoviesInteractorOutput!
    var ordersWorker = OrdersWorker(ordersStore: OrdersMemStore())
    
    var orders: [Movie]?
    
    // MARK: Business logic
  
    
    func fetchMovies(request: ListMovies.FetchMovies.Request)
    {
        ordersWorker.fetchOrders { (orders) -> Void in
            self.orders = orders
            let response = ListMovies.FetchMovies.Response(Movies: orders)
            self.output.presentFetchedMovies(response)
        }
    }
    
    func fetchMoviesForpagination(request: ListMovies.FetchMovies.RequestPagination) {
        
        ordersWorker.fetchOrders { (orders) -> Void in
            self.orders = self.ordersWorker.fetchMoviesForpagination(request.page!, item: request.limit!)
            let response = ListMovies.FetchMovies.Response(Movies: orders)
            self.output.presentFetchedMovies(response)
        }
    }
}

    

