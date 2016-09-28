

import UIKit

protocol ListOrdersRouterInput
{
  func navigateToSomewhere()
}

class ListOrdersRouter
{
  weak var viewController: ListOrdersViewController!
  
  // MARK: Navigation
  
  func navigateToSomewhere()
  {
    // NOTE: Teach the router how to navigate to another scene. Some examples follow:
    
    // 1. Trigger a storyboard segue
     viewController.performSegueWithIdentifier("segue", sender: nil)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    let destination = storyboard.instantiateViewControllerWithIdentifier("detailsView") as! ShowOrderViewController
    // 2. Present another view controller programmatically
     viewController.presentViewController(destination, animated: true, completion: nil)
    
    // 3. Ask the navigation controller to push another view controller onto the stack
     viewController.navigationController?.pushViewController(destination, animated: true)
    
    // 4. Present a view controller from a different storyboard
    
    
  }
  
  // MARK: Communication
  
  func passDataToNextScene(segue: UIStoryboardSegue)
  {
    // NOTE: Teach the router which scenes it can communicate with
    
    if segue.identifier == "segue" {
      passDataToSomewhereScene(segue)
    } else if segue.identifier == "segue" {
      passDataToShowOrderScene(segue)
    }
    
  }
  
  func passDataToSomewhereScene(segue: UIStoryboardSegue)
  {
    // NOTE: Teach the router how to pass data to the next scene
    
    // let someWhereViewController = segue.destinationViewController as! SomeWhereViewController
    // someWhereViewController.output.name = viewController.output.name
  }
  
  func passDataToShowOrderScene(segue: UIStoryboardSegue)
  {
    if let selectedIndexPath = viewController.tableView.indexPathForSelectedRow {
      if let selectedOrder = viewController.output.orders?[selectedIndexPath.row] {
        let showOrderViewController = segue.destinationViewController as! ShowOrderViewController
        showOrderViewController.output.order = selectedOrder
 
      }
    }
  }
}
