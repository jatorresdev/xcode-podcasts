//
//  PodcastDetailViewController.swift
//  Podcasts
//
//  Created by Angel Torres on 21/09/16.
//  Copyright © 2016 Angel Torres. All rights reserved.
//

import UIKit

class PodcastDetailViewController: UIViewController {
    var podcast: NSDictionary!
    
    @IBOutlet weak var imagePodcastDetail: UIImageView!
    @IBOutlet weak var descriptionPodcastDetail: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = podcast.value(forKey: "serie") as? String
        
        
        // Carga Image
        let image = podcast.value(forKey: "imagen") as? NSDictionary
        let url = NSURL(string: image?["src"] as! String)
        let data = NSData(contentsOf: url as! URL)
        imagePodcastDetail.image = UIImage(data: data as! Data)
        
        descriptionPodcastDetail.text = (podcast.value(forKey: "descripcion") as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
