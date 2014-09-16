//
//  DetailsViewController.swift
//  rottontomatoes
//
//  Created by Vidhya Suresh on 9/14/14.
//  Copyright (c) 2014 Vidhya Suresh. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    var titlename = ""
    var synopsisname = ""
    var imageURL = ""
    var synopsissize : CGFloat = 0
    @IBOutlet weak var detailsPosterView: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var detailsScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titlelabel.text = titlename
        synopsisLabel.text = synopsisname
        detailsPosterView.setImageWithURL(NSURL(string: imageURL))
        detailsScrollView.contentSize = CGSizeMake( detailsScrollView.frame.size.width, synopsissize )
       
        //print(synopsisname)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
