//
//  ProfileViewController.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/29/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var mainView: ProfileView!
    let viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.cancelButton.action = #selector(ProfileViewController.dismissSelf)
        
        LoadingHUD.sharedHUD.showInView(mainView)
        mainView.tableView.hidden = true
        
        viewModel.getCheckIns() { succeeded in
            if !succeeded { return }
            LoadingHUD.sharedHUD.hide()
            self.mainView.tableView.hidden = false
            self.mainView.tableView.reloadData()
        }
    }
    
    func dismissSelf(sender:AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }


}

extension ProfileViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.checkedInVenues != nil {
            return viewModel.checkedInVenues.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VenueTableViewCell") as! VenueTableViewCell
        cell.venue = viewModel.checkedInVenues[indexPath.row]
        return cell
    }

}

extension ProfileViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
}
