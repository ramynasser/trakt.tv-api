import Foundation

class OrdersAPI: OrdersStoreProtocol
{
  // MARK: - CRUD operations - Optional error
  
  func fetchOrders(completionHandler: (orders: [Movie], error: OrdersStoreError?) -> Void)
  {
  }
  
 
  
  // MARK: - CRUD operations - Generic enum result type
  
  func fetchOrders(completionHandler: OrdersStoreFetchOrdersCompletionHandler)
  {
  }
  
  
  // MARK: - CRUD operations - Inner closure
  
  func fetchOrders(completionHandler: (orders: () throws -> [Movie]) -> Void)
  {
  }
  
}
