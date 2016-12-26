//
//  ThirdViewController.swift
//  WellesleyFresh
//
//  Created by Audrey Seo on 15/10/2016.
//  Copyright © 2016 Audrey Seo. All rights reserved.
//

import UIKit
import MessageUI

class ThirdViewController: UIViewController, MFMailComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
	var tableview:UITableView = UITableView()
	var units:String = "Preferred Units"
	var unitOptions:[String] = ["m", "ft"]
	var items: [[String]] = [["HI", "Lol", "Preferred Units", "I just want to see if this works"], ["More Hi"]]
	var titles:[String] = ["Miscellaneous", "Feedback"]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableview.register(MyCell.self, forCellReuseIdentifier: "cellId")
		tableview.register(SegmentedControlCell.self, forCellReuseIdentifier: "segmentedCellId")
		
		// Assigns the class Header to the type of header cell that we use
		tableview.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
		tableview.delegate = self
		tableview.dataSource = self
		
		tableview.sizeToFit()
		
		// ty to this tutorial for the following code for auto-height for cells: https://www.raywenderlich.com/129059/self-sizing-table-view-cells
		tableview.estimatedRowHeight = 140
		
		self.view.addSubview(tableview)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		let tableX:CGFloat = self.view.frame.size.width * 0.025
		let tableY:CGFloat = 20.0;
		let tableW:CGFloat = self.view.frame.size.width * 0.95
		let tableH:CGFloat = (self.view.frame.size.height - tableY);
		tableview.frame = CGRect(x: CGFloat(tableX), y: tableY, width: tableW, height: tableH)
	}
	
	// ---------------------DELEGATE METHODS----------------------
	
	// Tableview
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return titles.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if (items[indexPath.section][indexPath.row].hasPrefix(units)) {
			print("Making a segmented control cell.")
			let myCell = tableView.dequeueReusableCell(withIdentifier: "segmentedCellId", for: indexPath) as! SegmentedControlCell
			if (items.count > 0) {
				myCell.nameLabel.text = items[indexPath.section][indexPath.row]
			} else {
				myCell.nameLabel.text = ""
			}
			myCell.setupSegmentedControl(items: unitOptions)
			return myCell
		} else {
			let myCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MyCell
			if (items.count > 0) {
				myCell.nameLabel.text = items[indexPath.section][indexPath.row]
			} else {
				myCell.nameLabel.text = ""
			}
			return myCell
		}
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return titles[section]
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let myHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId") as! Header
		//		if (self.chosenDiningHall != "") {
		//			myHeader.nameLabel.text = self.chosenDiningHall
		//		} else {
//		myHeader.nameLabel.text = titles[section]
		//		}
		//		myHeader.myTableViewController = self
		return myHeader
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items[section].count
	}
	
	// Mail
	
	
	func configuredMailComposeViewController(_ targetHall:String) -> MFMailComposeViewController {
		let mailComposerVC = MFMailComposeViewController()
		mailComposerVC.mailComposeDelegate = self
		
		mailComposerVC.setToRecipients(["\(targetHall)@somewhere.com"])
		mailComposerVC.setSubject("Sending an in-app email")
		mailComposerVC.setMessageBody("Start of an email!!\n", isHTML: false)
		
		return mailComposerVC
	}
	
	func showSendMailErrorAlert() {
		let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.alert)
		let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		sendMailErrorAlert.addAction(defaultAction)
		
		present(sendMailErrorAlert, animated: true, completion: nil)
	}
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: false, completion: nil)
	}
	
	@IBAction func pomFeedback(_ sender: AnyObject) {
		let mailComposeViewController = configuredMailComposeViewController("Pomeroy")
		if MFMailComposeViewController.canSendMail() {
			self.present(mailComposeViewController, animated: true, completion: nil)
		} else {
			self.showSendMailErrorAlert()
		}
	}
	@IBAction func towerFeedback(_ sender: AnyObject) {
		let mailComposeViewController = configuredMailComposeViewController("Tower")
		if MFMailComposeViewController.canSendMail() {
			self.present(mailComposeViewController, animated: true, completion: nil)
		} else {
			self.showSendMailErrorAlert()
		}
	}
	@IBAction func stonedFeedback(_ sender: AnyObject) {
		let mailComposeViewController = configuredMailComposeViewController("Stone_D")
		if MFMailComposeViewController.canSendMail() {
			self.present(mailComposeViewController, animated: true, completion: nil)
		} else {
			self.showSendMailErrorAlert()
		}
	}
	@IBAction func batesFeedback(_ sender: AnyObject) {
		let mailComposeViewController = configuredMailComposeViewController("Bates")
		if MFMailComposeViewController.canSendMail() {
			self.present(mailComposeViewController, animated: true, completion: nil)
		} else {
			self.showSendMailErrorAlert()
		}
	}
	@IBAction func bplcFeedback(_ sender: AnyObject) {
		let mailComposeViewController = configuredMailComposeViewController("BPLC")
		if MFMailComposeViewController.canSendMail() {
			self.present(mailComposeViewController, animated: true, completion: nil)
		} else {
			self.showSendMailErrorAlert()
		}
	}
	
}
