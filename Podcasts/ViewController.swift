//
//  ViewController.swift
//  Podcasts
//
//  Created by Angel Torres on 20/09/16.
//  Copyright © 2016 Angel Torres. All rights reserved.
//

import UIKit
import Moya

class ViewController: UITableViewController {
    var podcasts = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //downloadPodcasts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    fileprivate func showAlert(_ title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(ok)
//        present(alertController, animated: true, completion: nil)
//    }
//    
    
//    func downloadPodcasts() {
//        _ = PodcastsRadionicaProvider.request(.podcasts) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    if let json = try response.mapJSON() as? NSArray {
//                        self.podcasts = json
//                    } else {
//                        self.showAlert("Obtener podcasts", message: "No es posible obtener los podcasts de Radiónica")
//                    }
//                } catch {
//                    self.showAlert("Obtener podcasts", message: "No es posible obtener los podcasts de Radiónica")
//                }
//                self.tableView.reloadData()
//            case let .failure(error):
//                guard let error = error as? CustomStringConvertible else {
//                    break
//                }
//                self.showAlert("Obtener podcasts", message: error.description)
//            }
//        }
//    }
    
//    // MARK: - Table View
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        
//        return podcasts.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
//        let repo = podcasts[(indexPath as NSIndexPath).row] as? NSDictionary
//        cell.textLabel?.text = repo?["serie"] as? String
//        return cell
//    }

}

