

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ListOrdersViewController: ListMoviesPresenterOutput
{
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    router.passDataToNextScene(segue)
  }
}

extension ListOrdersInteractor: ListMoviesViewControllerOutput
{
}

extension ListOrdersPresenter: ListMoviesInteractorOutput
{
}

class ListOrdersConfigurator
{
  // MARK: Object lifecycle
  
  class var sharedInstance: ListOrdersConfigurator
  {
    struct Static {
      static var instance: ListOrdersConfigurator?
      static var token: dispatch_once_t = 0
    }
    
    dispatch_once(&Static.token) {
      Static.instance = ListOrdersConfigurator()
    }
    
    return Static.instance!
  }
  
  // MARK: Configuration
  
  func configure(viewController: ListOrdersViewController)
  {
    let router = ListOrdersRouter()
    router.viewController = viewController
    
    let presenter = ListOrdersPresenter()
    presenter.output = viewController
    
    let interactor = ListOrdersInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
