//
//  FilterViewController.swift
//  Yelp
//
//  Created by Le Thanh Tan on 11/19/15.
//  Copyright © 2015 Le Thanh Tan. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let categoriesString : String = "https://www.yelp.com/developers/documentation/v2/all_category_list/categories.json"
    var result : [NSDictionary] = [NSDictionary]();
    var switchStates = [Int:Bool]()
    var referenceCell: SwitchCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.fetchCategoriesFromServer()
    }
    
    func fetchCategoriesFromServer() {
        let URL : NSURL = NSURL(string: categoriesString)!
        let request : NSURLRequest = NSURLRequest(URL: URL)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { (data :NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            guard error == nil else  {
                print("error loading from URL", error!)
                return
            }
            
            self.result = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [NSDictionary]
            print(self.result)
            self.tableView.reloadData()
        }
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("switchCell") as! SwitchCell
        
        let title = self.result[indexPath.row]["title"] as? String
        cell.label.text = "\(title) adddwqdwqdqwdwqdwqdqwdqdqwdwdqwdqwdqwqdwqdwqdwqdwqdwqdqwdsfasfdaafda adddwqdwqdqwdwqdwqdqwdqdqwdwdqwdqwdqwqdwqdwqdwqdwqdwqdqwdsfasfdaafda adddwqdwqdqwdwqdwqdqwdqdqwdwdqwdqwdqwqdwqdwqdwqdwqdwqdqwdsfasfdaafda adddwqdwqdqwdwqdwqdqwdqdqwdwdqwdqwdqwqdwqdwqdwqdwqdwqdqwdsfasfdaafda"
        cell.swtichs.on = switchStates[indexPath.row] ?? false
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let data = self.result[indexPath.row]
        let name = data ["title"]
        let cell = tableView.dequeueReusableCellWithIdentifier("switchCell") as! SwitchCell
        cell.label.text = "\(name) adddwqdwqdqwdwqdwqdqwdqdqwdwdqwdqwdqwqdwqdwqdwqdwqdwqdqwdsfasfdaafda adddwqdwqdqwdwqdwqdqwdqdqwdwdqwdqwdqwqdwqdwqdwqdwqdwqdqwdsfasfdaafda adddwqdwqdqwdwqdwqdqwdqdqwdwdqwdqwdqwqdwqdwqdwqdwqdwqdqwdsfasfdaafda adddwqdwqdqwdwqdwqdqwdqdqwdwdqwdqwdqwqdwqdwqdwqdwqdwqdqwdsfasfdaafda)"

        cell.layoutSubviews()
        return cell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        
    }
    
    @IBAction func onCancelClick(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSearchClick(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension FilterViewController: SwitchCellDelegate {
    func switchCell(switchCell: SwitchCell, didChangeValued value: Bool) {
        let indexPath = self.tableView.indexPathForCell(switchCell)!
        switchStates[indexPath.row] = value
        
        print("Filter view controller \(indexPath)")
    }
}
