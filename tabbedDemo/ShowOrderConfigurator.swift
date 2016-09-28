

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ShowOrderViewController: ShowMoviePresenterOutput
{
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    router.passDataToNextScene(segue)
  }
}

extension ShowOrderInteractor: ShowMovieViewControllerOutput
{
}

extension ShowOrderPresenter: ShowMovieInteractorOutput
{
}

class ShowOrderConfigurator
{
  // MARK: Object lifecycle
  
  class var sharedInstance: ShowOrderConfigurator
  {
    struct Static {
      static var instance: ShowOrderConfigurator?
      static var token: dispatch_once_t = 0
    }
    
    dispatch_once(&Static.token) {
      Static.instance = ShowOrderConfigurator()
    }
    
    return Static.instance!
  }
  
  // MARK: Configuration
  
  func configure(viewController: ShowOrderViewController)
  {
    let router = ShowOrderRouter()
    router.viewController = viewController
    
    let presenter = ShowOrderPresenter()
    presenter.output = viewController
    
    let interactor = ShowOrderInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
