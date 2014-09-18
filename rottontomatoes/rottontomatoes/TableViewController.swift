//
//  TableViewController.swift
//  rottontomatoes
//
//  Created by Vidhya Suresh on 9/12/14.
//  Copyright (c) 2014 Vidhya Suresh. All rights reserved.
//

import UIKit

class TableViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var alertLabel: UILabel!
       @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary] = []
    var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        [MBProgressHUD .showHUDAddedTo(self.view, animated:true)]
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), { ()-> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.getdata()
                [MBProgressHUD .hideHUDForView(self.view , animated:true)]
                
                
            })
        })
        
        
        
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
    }
    
   
        func getdata(){
            
            tableView.delegate = self
            tableView.dataSource = self
          
         var neterror = NSErrorPointer()
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=u"
        
        var request = NSURLRequest(URL: NSURL(string : url))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()
            
            ){(response: NSURLResponse!, data: NSData!, error: NSError! )-> Void in
                
                var object = NSJSONSerialization.JSONObjectWithData(data, options:
                    nil, error : nil ) as NSDictionary
                
                
                
                if(object["movies"] == nil){
                   // [TWMessageBarManager .sharedInstance() .showMessageWithTitle("Network Error!", description: "Unable to connect to URL", type: TWMessageBarMessageTypeError , duration : 1000 , callback: {
                        
                     //   self.getdata()
                       // }
                        
                   // )]
                    self.alertLabel.text = "Network Error!"
                    
                }
                
                else{
                
                self.movies = object["movies"] as [NSDictionary]
                
                
                
                self.tableView.reloadData()
                
                }
               
                
        
        }

        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell")as MovieCell
        
        var movie = movies[indexPath.row]
        
        cell.movieTitleLabel.text = movie["title"] as?  String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        var poster = movie["posters"] as NSDictionary
        var posterurl = poster["thumbnail"] as String
        
        cell.posterView.setImageWithURL(NSURL(string: posterurl))
        
        
        //cell.textLabel!.text = "I am in row \(indexPath.row) , section \(indexPath.section)"
        
        return cell
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if(segue.identifier == "detailsSeague"){
            let detailsseague = segue.destinationViewController as DetailsViewController
            var getrow = tableView!.indexPathForSelectedRow()?.row
            var movie = movies[getrow!]
            var titlename = movie["title"] as String
            var synopsis = movie["synopsis"] as String
            var poster = movie["posters"] as NSDictionary
            var posterurl = poster["original"] as String
            var posterURL = posterurl.stringByReplacingOccurrencesOfString("tmb", withString: "org", options: NSStringCompareOptions.LiteralSearch, range: nil)
           // print (titlename)
            detailsseague.titlename = titlename
            detailsseague.synopsisname = synopsis.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            detailsseague.imageURL = posterURL
            detailsseague.synopsissize = CGFloat(countElements(synopsis))
            //print(countElements(synopsis))
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
